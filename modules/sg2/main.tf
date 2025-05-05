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

# Create ingress rules
resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  
  from_port   = var.ingress_rules[count.index].from_port
  to_port     = var.ingress_rules[count.index].to_port
  protocol    = var.ingress_rules[count.index].protocol
  cidr_blocks = var.ingress_rules[count.index].cidr_blocks
  description = var.ingress_rules[count.index].description
}

# Create egress rules
resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  security_group_id = aws_security_group.this.id
  type              = "egress"
  
  from_port   = var.egress_rules[count.index].from_port
  to_port     = var.egress_rules[count.index].to_port
  protocol    = var.egress_rules[count.index].protocol
  cidr_blocks = var.egress_rules[count.index].cidr_blocks
  description = var.egress_rules[count.index].description
}

# Create security group rules with source_security_group_id
resource "aws_security_group_rule" "source_sg" {
  count = length(var.source_security_group_rules)

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  
  from_port                = var.source_security_group_rules[count.index].from_port
  to_port                  = var.source_security_group_rules[count.index].to_port
  protocol                 = var.source_security_group_rules[count.index].protocol
  source_security_group_id = var.source_security_group_rules[count.index].source_security_group_id
  description              = var.source_security_group_rules[count.index].description
}