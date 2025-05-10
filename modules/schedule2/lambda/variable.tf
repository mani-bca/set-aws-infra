variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ec2-scheduler"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "source_file_path" {
  description = "Path to the Lambda function source file"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

variable "runtime" {
  description = "Runtime for Lambda function"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "Timeout for Lambda function (in seconds)"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Memory size for Lambda function (in MB)"
  type        = number
  default     = 128
}

variable "description" {
  description = "Description for the Lambda function"
  type        = string
  default     = "Lambda function created by Terraform"
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda function"
  type        = string
}

variable "cloudwatch_event_rule_arn" {
  description = "ARN of the CloudWatch Event rule for triggering the Lambda function"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
