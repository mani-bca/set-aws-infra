output "lambda_permission_id" {
  description = "ID of the Lambda permission"
  value       = aws_lambda_permission.cloudwatch_trigger.id
}

output "event_target_id" {
  description = "ID of the CloudWatch Event target"
  value       = aws_cloudwatch_event_target.lambda_target.id
}