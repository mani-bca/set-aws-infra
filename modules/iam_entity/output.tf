output "iam_role_arn" {
  value = var.type == "role" ? aws_iam_role.this[0].arn : null
}

output "iam_user_arn" {
  value = var.type == "user" ? aws_iam_user.this[0].arn : null
}

output "iam_group_arn" {
  value = var.type == "group" ? aws_iam_group.this[0].arn : null
}
