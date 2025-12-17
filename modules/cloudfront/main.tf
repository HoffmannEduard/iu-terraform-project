# Access Controll um auf private Buckets zugreifen zu können
resource "aws_cloudfront_origin_access_control" "oac" {
  name = "s3-oac"
  description = "OAC for private S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

# Cloudfront Instanz
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  default_root_object = "index.html"


  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = "s3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    
    target_origin_id       = "s3Origin"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
