variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "start_cron_expression" {
  description = "Cron expression for starting EC2 instances"
  type        = string
}

variable "stop_cron_expression" {
  description = "Cron expression for stopping EC2 instances"
  type        = string
}

variable "start_lambda_function_name" {
  description = "Name of the Lambda function for starting EC2 instances"
  type        = string
}

variable "stop_lambda_function_name" {
  description = "Name of the Lambda function for stopping EC2 instances"
  type        = string
}

variable "start_lambda_function_arn" {
  description = "ARN of the Lambda function for starting EC2 instances"
  type        = string
}

variable "stop_lambda_function_arn" {
  description = "ARN of the Lambda function for stopping EC2 instances"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}