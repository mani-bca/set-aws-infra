resource "aws_sns_topic" "this" {
  name = var.topic_name
  tags = var.tags
}
resource "aws_sns_topic_subscription" "email" {
  count     = length(var.email_addresses)
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = var.email_addresses[count.index]
}
resource "aws_lambda_permission" "sns_permission" {
  count         = var.lambda_function_arn != "" ? 1 : 0
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}
