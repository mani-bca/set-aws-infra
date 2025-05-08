# modules/iam/main.tf

# IAM role for the Lambda functions
resource "aws_iam_role" "lambda_role" {
  for_each = var.lambda_roles

  name        = "${var.name_prefix}-${each.key}-role"
  description = each.value.description

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.key}-role"
    }
  )
}

# Lambda basic execution policy for CloudWatch Logs
resource "aws_iam_policy" "lambda_basic_execution" {
  name        = "${var.name_prefix}-lambda-basic-execution"
  description = "Policy for Lambda basic execution with CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# EC2 start policy
resource "aws_iam_policy" "ec2_start_policy" {
  name        = "${var.name_prefix}-ec2-start-policy"
  description = "Policy for starting EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:StartInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# EC2 stop policy
resource "aws_iam_policy" "ec2_stop_policy" {
  name        = "${var.name_prefix}-ec2-stop-policy"
  description = "Policy for stopping EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:StopInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# VPC access policy (if Lambda needs to access resources in VPC)
resource "aws_iam_policy" "vpc_access" {
  count = var.create_vpc_access_policy ? 1 : 0

  name        = "${var.name_prefix}-vpc-access"
  description = "Policy for Lambda VPC access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach policies to roles
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  for_each = var.lambda_roles

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_basic_execution.arn
}

resource "aws_iam_role_policy_attachment" "vpc_access" {
  for_each = var.create_vpc_access_policy ? var.lambda_roles : {}

  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.vpc_access[0].arn
}

resource "aws_iam_role_policy_attachment" "ec2_start_policy" {
  role       = aws_iam_role.lambda_role["start-ec2"].name
  policy_arn = aws_iam_policy.ec2_start_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_stop_policy" {
  role       = aws_iam_role.lambda_role["stop-ec2"].name
  policy_arn = aws_iam_policy.ec2_stop_policy.arn
}

# Custom policy attachments
resource "aws_iam_role_policy_attachment" "custom_policies" {
  for_each = {
    for item in local.role_policy_attachments : "${item.role_key}.${item.policy_arn}" => item
  }

  role       = aws_iam_role.lambda_role[each.value.role_key].name
  policy_arn = each.value.policy_arn
}

locals {
  role_policy_attachments = flatten([
    for role_key, role in var.lambda_roles : [
      for policy_arn in role.additional_policy_arns : {
        role_key   = role_key
        policy_arn = policy_arn
      }
    ]
  ])
}