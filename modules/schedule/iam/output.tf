# modules/iam/outputs.tf

output "lambda_role_arns" {
  description = "ARNs of the Lambda IAM roles"
  value       = { for k, v in aws_iam_role.lambda_role : k => v.arn }
}

output "lambda_role_names" {
  description = "Names of the Lambda IAM roles"
  value       = { for k, v in aws_iam_role.lambda_role : k => v.name }
}