resource "aws_kms_key" "s3key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "prod_bucket" {
    bucket = "${var.name}-eks-${var.environment}-bucket"
    versioning {
    enabled = true
    //mfa_delete = true
  }
    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }
   server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.s3key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = {
    Name        = "Sapidblue-S3-Bucket"
    Environment = "${var.environment}"
  }
#     policy = <<EOF
# {
#     "Version": "2008-10-17",
#     "Statement": [
#     {
#         "Sid": "PublicReadForGetBucketObjects",
#         "Effect": "Allow",
#         "Principal": {
#             "AWS": "*"
#          },
#          "Action": "s3:GetObject",
#          "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
#     }, {
#         "Sid": "",
#         "Effect": "Allow",
#         "Principal": {
#             "AWS": "${aws_iam_user.prod_user.arn}"
#         },
#         "Action": "s3:*",
#         "Resource": [
#             "arn:aws:s3:::YOUR-BUCKET-NAME",
#             "arn:aws:s3:::YOUR-BUCKET-NAME/*"
#         ]
#     }]
# }
# EOF 
}
resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.name}-eks-${var.environment}-log-bucket"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.prod_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.prod_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "s3bucket" {
  bucket = aws_s3_bucket.prod_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_cloudfront_distribution" "sapidblue-cdn-eks" {
  origin {
    domain_name = "spadblue.com"
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
    Product = "Sapidblue"
    Environment = var.environment
  }
}
