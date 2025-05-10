resource "aws_iam_role" "this" {
  count              = var.type == "role" ? 1 : 0
  name               = var.name
  assume_role_policy = var.trust_policy_json
}

resource "aws_iam_user" "this" {
  count = var.type == "user" ? 1 : 0
  name  = var.name
}

resource "aws_iam_group" "this" {
  count = var.type == "group" ? 1 : 0
  name  = var.name
}

resource "aws_iam_role_policy_attachment" "role_attachment" {
  count      = var.type == "role" ? length(var.aws_managed_policy_arns) : 0
  role       = aws_iam_role.this[0].name
  policy_arn = var.aws_managed_policy_arns[count.index]
}

resource "aws_iam_user_policy_attachment" "user_attachment" {
  count      = var.type == "user" ? length(var.aws_managed_policy_arns) : 0
  user       = aws_iam_user.this[0].name
  policy_arn = var.aws_managed_policy_arns[count.index]
}

resource "aws_iam_group_policy_attachment" "group_attachment" {
  count      = var.type == "group" ? length(var.aws_managed_policy_arns) : 0
  group      = aws_iam_group.this[0].name
  policy_arn = var.aws_managed_policy_arns[count.index]
}

resource "aws_iam_role_policy" "inline_role_policies" {
  for_each = var.type == "role" ? var.inline_policies : {}

  name   = each.key
  role   = aws_iam_role.this[0].name
  policy = file(each.value)
}

resource "aws_iam_user_policy" "inline_user_policies" {
  for_each = var.type == "user" ? var.inline_policies : {}

  name   = each.key
  user   = aws_iam_user.this[0].name
  policy = file(each.value)
}

resource "aws_iam_group_policy" "inline_group_policies" {
  for_each = var.type == "group" ? var.inline_policies : {}

  name   = each.key
  group  = aws_iam_group.this[0].name
  policy = file(each.value)
}
