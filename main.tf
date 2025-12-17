terraform {
    required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "cloudfront" {
  source = "./modules/cloudfront"
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}

module "s3_policy" {
  source = "./modules/s3_policy"
  bucket_name = var.bucket_name
  bucket_arn = module.s3.bucket_arn
  cloudfront_distribution_arn = module.cloudfront.distribution_arn
}

module "lambda" {
  source = "./modules/lambda"
  lambda_name = var.lambda_name
}

module "apigateway" {
  source = "./modules/apigateway"
  api_name = var.apigateway_name
  api_path = var.api_path
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
  lambda_name = module.lambda.lambda_name
}


