variable "api_name" {
  type        = string
  description = "Name der API Gateway REST API"
}

variable "api_path" {
  type        = string
  description = "Pfad der API"
}

variable "http_method" {
  type        = string
  default     = "POST"
  description = "HTTP Methode für den Endpoint"
}

variable "lambda_invoke_arn" {
  type        = string
  description = "Invoke ARN der Lambda Funktion"
}

variable "lambda_name" {
  type        = string
  description = "Name der Lambda Funktion"
}

variable "stage_name" {
  type        = string
  default     = "dev"
  description = "Name des API Stage"
}
