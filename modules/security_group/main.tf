# modules/security_group/main.tf

terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_security_group" "this" {
  name        = "${var.name_prefix}-${var.name}"
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${var.name}"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = { for idx, rule in var.ingress_rules : idx => rule }

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = lookup(each.value, "protocol", "tcp")
  description       = lookup(each.value, "description", "Ingress Rule ${each.key}")
  
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  ipv6_cidr_blocks  = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids   = lookup(each.value, "prefix_list_ids", null)
  security_groups   = lookup(each.value, "security_groups", null)
  self              = lookup(each.value, "self", null)
}

resource "aws_security_group_rule" "egress" {
  for_each = { for idx, rule in var.egress_rules : idx => rule }

  security_group_id = aws_security_group.this.id
  type              = "egress"
  
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = lookup(each.value, "protocol", "-1")
  description       = lookup(each.value, "description", "Egress Rule ${each.key}")
  
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  ipv6_cidr_blocks  = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids   = lookup(each.value, "prefix_list_ids", null)
  security_groups   = lookup(each.value, "security_groups", null)
  self              = lookup(each.value, "self", null)
}