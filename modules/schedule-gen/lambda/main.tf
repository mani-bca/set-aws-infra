# modules/lambda/main.tf

resource "aws_lambda_function" "this" {
  for_each         = { for lambda in var.lambda_functions : lambda.name => lambda }
  
  filename         = data.archive_file.lambda_zip[each.key].output_path
  function_name    = "${var.project_name}-${var.environment}-${each.key}"
  role             = var.lambda_role_arn
  handler          = each.value.handler
  source_code_hash = data.archive_file.lambda_zip[each.key].output_base64sha256
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size
  description      = each.value.description

  environment {
    variables = merge(
      {
        EC2_INSTANCE_IDS = join(",", var.ec2_instance_ids)
      },
      each.value.environment_variables
    )
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-${each.key}"
    },
    each.value.tags
  )
}

data "archive_file" "lambda_zip" {
  for_each    = { for lambda in var.lambda_functions : lambda.name => lambda }
  type        = "zip"
  source_file = each.value.file_path
  output_path = "${path.module}/${each.key}.zip"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  for_each      = { for lambda in var.lambda_functions : lambda.name => lambda if lambda.cloudwatch_event_rule_arn != null }
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[each.key].function_name
  principal     = "events.amazonaws.com"
  source_arn    = each.value.cloudwatch_event_rule_arn
}
