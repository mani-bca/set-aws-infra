# modules/ec2/variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "List of subnet IDs for EC2 instances"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs for EC2 instances"
  type        = list(string)
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = null
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

