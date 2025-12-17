output "s3_bucket_name" {
  value = module.s3.bucket_regional_domain_name
}

output "cloudfront_url" {
  value = module.cloudfront.domain_name
}

output "api_url" {
  value = module.apigateway.api_url
}