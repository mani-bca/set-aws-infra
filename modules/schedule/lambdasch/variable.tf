# modules/lambda/variables.tf

variable "name_prefix" {
  description = "Prefix to be used for all resources"
  type        = string
  default     = "ec2-scheduler"
}

variable "lambda_functions" {
  description = "Map of Lambda functions to create"
  type = map(object({
    filename               = string
    description            = string
    handler                = string
    role_arn               = string
    scheduler_arn          = string
    environment_variables  = map(string)
  }))
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Lambda memory size in MB"
  type        = number
  default     = 128
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Lambda function"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security group IDs for the Lambda function"
  type        = list(string)
  default     = []
}

variable "environment_variables" {
  description = "Environment variables for all Lambda functions"
  type        = map(string)
  default     = {}
}

variable "log_retention_in_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 14
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}