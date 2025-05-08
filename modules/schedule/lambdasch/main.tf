# modules/lambda/main.tf

data "archive_file" "lambda_zip" {
  for_each = var.lambda_functions

  type        = "zip"
  source_file = "${path.module}/files/${each.value.filename}"
  output_path = "${path.module}/files/${each.key}.zip"
}

resource "aws_lambda_function" "this" {
  for_each = var.lambda_functions

  function_name    = "${var.name_prefix}-${each.key}"
  description      = each.value.description
  filename         = data.archive_file.lambda_zip[each.key].output_path
  source_code_hash = data.archive_file.lambda_zip[each.key].output_base64sha256
  handler          = each.value.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  role             = each.value.role_arn

  vpc_config {
    subnet_ids         = length(var.subnet_ids) > 0 ? var.subnet_ids : null
    security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : null
  }

  environment {
    variables = merge(
      var.environment_variables,
      each.value.environment_variables
    )
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.key}"
    }
  )
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  for_each = var.lambda_functions

  name              = "/aws/lambda/${aws_lambda_function.this[each.key].function_name}"
  retention_in_days = var.log_retention_in_days
  tags              = var.tags
}

resource "aws_lambda_permission" "allow_eventbridge" {
  for_each = var.lambda_functions

  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[each.key].function_name
  principal     = "events.amazonaws.com"
  source_arn    = each.value.scheduler_arn
}