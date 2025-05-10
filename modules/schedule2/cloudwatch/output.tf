
output "start_cloudwatch_event_rule_arn" {
  description = "ARN of the CloudWatch Event rule for starting EC2 instances"
  value       = aws_cloudwatch_event_rule.start_ec2_instances.arn
}

output "stop_cloudwatch_event_rule_arn" {
  description = "ARN of the CloudWatch Event rule for stopping EC2 instances"
  value       = aws_cloudwatch_event_rule.stop_ec2_instances.arn
}