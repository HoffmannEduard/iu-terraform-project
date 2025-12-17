resource "aws_s3_bucket_policy" "allow_cloudfront" {

  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Id = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid = "AllowCloudFrontOAC"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "${var.bucket_arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.cloudfront_distribution_arn
          }
        }
      }
    ]
  })
}
