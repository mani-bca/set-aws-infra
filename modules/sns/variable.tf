variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "email_addresses" {
  description = "List of email addresses to subscribe to the SNS topic"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to the SNS topic"
  type        = map(string)
  default     = {}
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to trigger from SNS"
  type        = string
  default     = ""
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to trigger from SNS"
  type        = string
  default     = ""
}