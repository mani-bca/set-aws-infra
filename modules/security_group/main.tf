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

  dynamic "ingress" {
    for_each = var.ingress_with_cidr_blocks
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = lookup(ingress.value, "protocol", "tcp")
      cidr_blocks = ingress.value.cidr_blocks
      description = lookup(ingress.value, "description", "Ingress Rule ${ingress.key}")
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = lookup(egress.value, "protocol", "-1")
      cidr_blocks = lookup(egress.value, "cidr_blocks", ["0.0.0.0/0"])
      description = lookup(egress.value, "description", "Egress Rule ${egress.key}")
    }
  }

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

# Create separate security group rules for rules with source_security_group_id
resource "aws_security_group_rule" "ingress_security_groups" {
  for_each = { for idx, rule in var.ingress_with_source_security_group_id : idx => rule }

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = lookup(each.value, "protocol", "tcp")
  source_security_group_id = each.value.source_security_group_id
  description              = lookup(each.value, "description", "Ingress Rule SG ${each.key}")
}