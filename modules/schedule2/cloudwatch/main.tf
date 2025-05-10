resource "aws_cloudwatch_event_rule" "start_ec2_instances" {
  name                = "${var.project_name}-${var.environment}-start-ec2-instances"
  description         = "Triggers Lambda function to start EC2 instances at specified time"
  schedule_expression = var.start_cron_expression
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-start-ec2-instances"
    }
  )
}

resource "aws_cloudwatch_event_rule" "stop_ec2_instances" {
  name                = "${var.project_name}-${var.environment}-stop-ec2-instances"
  description         = "Triggers Lambda function to stop EC2 instances at specified time"
  schedule_expression = var.stop_cron_expression
  
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-stop-ec2-instances"
    }
  )
}

resource "aws_cloudwatch_event_target" "start_ec2_instances" {
  rule      = aws_cloudwatch_event_rule.start_ec2_instances.name
  target_id = "start_ec2_instances"
  arn       = var.start_lambda_function_arn
}

resource "aws_cloudwatch_event_target" "stop_ec2_instances" {
  rule      = aws_cloudwatch_event_rule.stop_ec2_instances.name
  target_id = "stop_ec2_instances"
  arn       = var.stop_lambda_function_arn
}
