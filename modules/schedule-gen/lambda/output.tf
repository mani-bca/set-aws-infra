output "lambda_function_names" {
  description = "Map of Lambda function names"
  value       = { for k, v in aws_lambda_function.this : k => v.function_name }
}

output "lambda_function_arns" {
  description = "Map of Lambda function ARNs"
  value       = { for k, v in aws_lambda_function.this : k => v.arn }
}