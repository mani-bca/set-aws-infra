locals {
  function_name = "${var.project_name}-${var.environment}-${var.function_name}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = var.source_file_path
  output_path = "${path.module}/${var.function_name}.zip"
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = local.function_name
  role             = var.lambda_role_arn
  handler          = var.handler
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  description      = var.description

  environment {
    variables = var.environment_variables
  }

  tags = merge(
    var.tags,
    {
      Name = local.function_name
    }
  )
}

resource "aws_lambda_permission" "cloudwatch_trigger" {
  count         = var.cloudwatch_event_rule_arn != null ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_event_rule_arn
}
