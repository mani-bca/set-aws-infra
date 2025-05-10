variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "rule_name" {
  description = "Name of the CloudWatch Event rule"
  type        = string
}

variable "description" {
  description = "Description of the CloudWatch Event rule"
  type        = string
}

variable "cron_expression" {
  description = "Cron expression for the CloudWatch Event rule"
  type        = string
}

variable "target_id" {
  description = "Target ID for the CloudWatch Event rule"
  type        = string
  default     = "lambda"
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to target"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}