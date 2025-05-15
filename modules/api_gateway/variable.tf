
variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "description" {
  description = "Description for the API Gateway"
  type        = string
  default     = ""
}

variable "resource_path" {
  description = "Path part for the resource"
  type        = string
}

variable "http_method" {
  description = "HTTP Method (e.g., GET, POST)"
  type        = string
}

variable "authorization" {
  description = "Authorization type (e.g., NONE, AWS_IAM)"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  type        = string
}

variable "stage_name" {
  description = "Deployment stage name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}
