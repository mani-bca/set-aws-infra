# modules/event_lambda_connector/main.tf

resource "aws_lambda_permission" "cloudwatch_trigger" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_event_rule_arn
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = var.cloudwatch_event_rule_name
  target_id = var.target_id
  arn       = var.lambda_function_arn
  
  depends_on = [aws_lambda_permission.cloudwatch_trigger]
}


