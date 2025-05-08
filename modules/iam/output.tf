output "role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.this.name
}

output "policy_arn" {
  description = "The ARN of the IAM policy"
  value       = aws_iam_policy.this.arn
}

output "s3_permission" {
  description = "The S3 permission resource"
  value       = var.enable_s3_trigger ? aws_lambda_permission.s3_permission[0] : null
}

output "sns_permission" {
  description = "The SNS permission resource"
  value       = var.enable_sns_trigger ? aws_lambda_permission.sns_permission[0] : null
}