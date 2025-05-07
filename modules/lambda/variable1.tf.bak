variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_source_file" {
  description = "Path to the Lambda function source file"
  type        = string
  default     = ""
}

variable "lambda_source_dir" {
  description = "Path to the Lambda function source directory"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "nodejs18.x"
}

variable "timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the Lambda function"
  type        = map(string)
  default     = {}
}

variable "additional_policy_statements" {
  description = "Additional IAM policy statements for the Lambda function"
  type        = list(any)
  default     = []
}

variable "enable_s3_trigger" {
  description = "Whether to enable S3 bucket trigger for the Lambda function"
  type        = bool
  default     = false
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket that triggers the Lambda function"
  type        = string
  default     = ""
}

variable "lambda_layers" {
  description = "List of Lambda Layer ARNs to attach to the function"
  type        = list(string)
  default     = []
}