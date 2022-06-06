resource "aws_cloudfront_distribution" "sapidblue-cdn-eks" {
  origin {
    domain_name = "${var.lcms_api_domain}-${var.environment}.${var.main_domain}"
    #origin_path = "/${var.environment}"
    origin_id   = "api"

    custom_origin_config {
			http_port              = 80
			https_port             = 443
			origin_protocol_policy = "https-only"
			origin_ssl_protocols   = ["TLSv1","TLSv1.1"]
    }
  }

  enabled             = true

  aliases = ["${var.sapidblue_cdn_domain}-${var.environment}.${var.main_domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "api"

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
		acm_certificate_arn      = var.api_certificate_arn
		minimum_protocol_version = "TLSv1.1_2016"
		ssl_support_method       = "sni-only"
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

resource "aws_route53_record" "sapidblue_cf_route_53_record" {
  name = "${var.lcms_cdn_domain}-${var.environment}"
  type = "A"
  zone_id = var.zone_id

  alias {
    name                   = "${aws_cloudfront_distribution.sapidblue-cdn-eks.domain_name}"
    zone_id                = aws_cloudfront_distribution.sapidblue-cdn-eks.hosted_zone_id
    evaluate_target_health = false
  }
}