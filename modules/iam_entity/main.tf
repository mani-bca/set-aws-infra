resource "aws_iam_role" "this" {
  count = var.type == "role" ? 1 : 0
  name  = var.name

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

resource "aws_iam_role_policy" "inline" {
  for_each = var.type == "role" ? var.inline_policies : {}

  name   = each.key
  role   = aws_iam_role.this[0].name
  policy = file(each.value)
}

resource "aws_iam_role_policy_attachment" "managed" {
  count      = var.type == "role" ? length(var.aws_managed_policy_arns) : 0
  role       = aws_iam_role.this[0].name
  policy_arn = var.aws_managed_policy_arns[count.index]
}
