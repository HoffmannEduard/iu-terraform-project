# AWS Region
variable "aws_region" {
  description = "AWS Region für Ressourcen"
  type = string
  default = "eu-central-1"
}

# S3 Bucket Name
variable "bucket_name" {
  description = "Name des S3 Buckets für die Website"
  type = string
}

# Lambda Function Name
variable "lambda_name" {
  description = "Name der Lambda Funktion"
  type = string
}

# API Gateway Name
variable "apigateway_name" {
  description = "Name der API"
  type = string
}

# API Pfad
variable "api_path" {
  description = "Pfad der API"
  type = string
  default = "hello"
}

