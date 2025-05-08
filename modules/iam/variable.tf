variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "policy_description" {
  description = "Description of the IAM policy"
  type        = string
  default     = "Policy created by Terraform"
}

variable "service_principal" {
  description = "AWS service principal that can assume this role"
  type        = string
  default     = "lambda.amazonaws.com"
}

variable "policy_statements" {
  description = "List of policy statements"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}

variable "enable_s3_trigger" {
  description = "Whether to enable S3 bucket trigger"
  type        = bool
  default     = false
}

variable "enable_sns_trigger" {
  description = "Whether to enable SNS topic trigger"
  type        = bool
  default     = false
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = ""
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket that triggers the Lambda function"
  type        = string
  default     = ""
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic that triggers the Lambda function"
  type        = string
  default     = ""
}