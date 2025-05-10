variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "lambda_functions" {
  description = "List of Lambda functions to create"
  type = list(object({
    name                   = string
    file_path              = string
    handler                = string
    description            = string
    cloudwatch_event_rule_arn = optional(string)
    environment_variables  = optional(map(string), {})
    tags                   = optional(map(string), {})
  }))
}

variable "lambda_runtime" {
  description = "Runtime for Lambda functions"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout for Lambda functions (in seconds)"
  type        = number
}

variable "lambda_memory_size" {
  description = "Memory size for Lambda functions (in MB)"
  type        = number
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda functions"
  type        = string
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to be managed"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}