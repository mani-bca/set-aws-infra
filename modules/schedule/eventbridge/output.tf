# modules/eventbridge/outputs.tf

output "schedule_arns" {
  description = "ARNs of the EventBridge Scheduler schedules"
  value       = { for k, v in aws_scheduler_schedule.this : k => v.arn }
}

output "schedule_group_arn" {
  description = "ARN of the EventBridge Scheduler schedule group"
  value       = aws_scheduler_schedule_group.this.arn
}