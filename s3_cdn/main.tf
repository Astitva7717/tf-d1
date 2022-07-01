resource "aws_s3_bucket" "prod_bucket" {
    bucket = lower("${var.name}-manual-content")
    versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.name}-manual-content"
    Environment = "${var.environment}"
  } 
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.prod_bucket.id
  acl    = "private"
}



resource "aws_cloudfront_distribution" "s3-cdn-eks" {
  origin {
    domain_name = lower("${var.name}-manual-content.s3.${var.region}.amazonaws.com")
    #origin_path = "/${var.environment}"
    origin_id   = "S3-${aws_s3_bucket.prod_bucket.bucket}"

    custom_origin_config {
			http_port              = 80
			https_port             = 443
			origin_protocol_policy = "https-only"
			origin_ssl_protocols   = ["TLSv1","TLSv1.1","TLSv1.2"]
    }
  }

  enabled             = true

  //aliases = ["${var.sapidblue_cdn_domain}-${var.environment}.${var.main_domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "S3-${aws_s3_bucket.prod_bucket.bucket}"

    forwarded_values {
      query_string = true
			headers = ["Accept", "Referer", "Authorization", "Content-Type"]
			cookies {
				forward = "all"
			}
    }
		compress = true
		viewer_protocol_policy = "https-only"
  }

  price_class = "PriceClass_All"
  viewer_certificate {
        cloudfront_default_certificate = true
    }
	restrictions {
		geo_restriction {
			restriction_type = "none"
		}
	}
  tags = {
    Name        = "${var.name}-manual-content"
    Environment = var.environment
  }
}

resource "aws_iam_role" "eks_s3_access_role" {
  name               = "${var.name}-ks-document-upload-role-${var.environment}"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}

resource "aws_iam_policy" "s3-eks-policy" {
  name        = "${var.name}-ks-document-upload-policy-${var.environment}"
  description = "S3 Bucket policy for EKS access"
  policy      = "${file("policy.json")}"
}