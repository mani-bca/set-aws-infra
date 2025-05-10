# modules/lambda/main.tf

locals {
  function_name = "${var.project_name}-${var.environment}-${var.function_name}"
}

resource "aws_lambda_function" "this" {
  filename         = var.lambda_zip_path
  function_name    = local.function_name
  role             = var.lambda_role_arn
  handler          = var.handler
  source_code_hash = filebase64sha256(var.lambda_zip_path)
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  description      = var.description

  environment {
    variables = var.environment_variables
  }

  tags = merge(
    var.tags,
    {
      Name = local.function_name
    }
  )
}

resource "aws_lambda_permission" "cloudwatch_trigger" {
  count         = var.cloudwatch_event_rule_arn != null ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_event_rule_arn
}

# modules/lambda/variables.tf

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

variable "lambda_zip_path" {
  description = "Path to the zipped Lambda function code"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "lambda_function.lambda_handler"
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

