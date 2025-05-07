variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "enable_notification" {
  description = "Whether to enable S3 bucket notifications"
  type        = bool
  default     = false
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to trigger"
  type        = string
  default     = ""
}

variable "lambda_permission" {
  description = "Lambda permission resource to depend on"
  type        = any
  default     = null
}