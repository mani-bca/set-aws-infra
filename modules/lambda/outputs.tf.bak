output "function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.lambda_role.arn
}

output "s3_permission" {
  description = "The S3 permission resource"
  value       = var.enable_s3_trigger ? aws_lambda_permission.s3_permission[0] : null
}