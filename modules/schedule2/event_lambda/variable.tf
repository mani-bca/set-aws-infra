variable "cloudwatch_event_rule_arn" {
  description = "ARN of the CloudWatch Event rule"
  type        = string
}

variable "cloudwatch_event_rule_name" {
  description = "Name of the CloudWatch Event rule"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function"
  type        = string
}

variable "target_id" {
  description = "Target ID for the CloudWatch Event target"
  type        = string
}
