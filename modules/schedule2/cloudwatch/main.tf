resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.project_name}-${var.environment}-${var.rule_name}"
  description         = var.description
  schedule_expression = var.cron_expression
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.rule_name}"
    }
  )
}

resource "aws_cloudwatch_event_target" "this" {
  count     = var.lambda_function_arn != null ? 1 : 0
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.target_id
  arn       = var.lambda_function_arn
}
