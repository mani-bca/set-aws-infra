# modules/security_group/variables.tf

variable "name_prefix" {
  description = "Prefix to use for naming resources"
  type        = string
}

variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group managed by Terraform"
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules to create"
  type        = list(any)
  default     = []
}

variable "egress_rules" {
  description = "List of egress rules to create"
  type        = list(any)
  default     = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}