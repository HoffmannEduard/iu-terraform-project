output "distribution_arn" {
  value = aws_cloudfront_distribution.cdn.arn
}

output "domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "oac_id" {
  value = aws_cloudfront_origin_access_control.oac.id
}
