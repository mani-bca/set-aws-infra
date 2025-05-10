resource "aws_cloudwatch_event_rule" "this" {
  name        = var.name
  description = var.description
  schedule_expression = var.schedule_expression
  event_pattern       = var.event_pattern
  is_enabled          = var.enabled
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.target_id
  arn       = var.target_arn
  role_arn  = var.role_arn

  dynamic "input_transformer" {
    for_each = var.input_transformer != null ? [1] : []
    content {
      input_paths    = var.input_transformer["input_paths"]
      input_template = var.input_transformer["input_template"]
    }
  }

  input      = var.input
  input_path = var.input_path
}
