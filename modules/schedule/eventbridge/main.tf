# modules/eventbridge/main.tf

# Create EventBridge Scheduler schedule groups
resource "aws_scheduler_schedule_group" "this" {
  name = var.schedule_group_name

  tags = var.tags
}

# Create EventBridge Scheduler schedules
resource "aws_scheduler_schedule" "this" {
  for_each = var.schedules

  name       = "${var.name_prefix}-${each.key}"
  group_name = aws_scheduler_schedule_group.this.name

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = each.value.schedule_expression
  
  target {
    arn      = each.value.target_arn
    role_arn = each.value.role_arn

    input = jsonencode(
      try(each.value.input, {})
    )
  }

  state = "ENABLED"

  description = each.value.description

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.key}"
    }
  )
}