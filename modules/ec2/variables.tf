# modules/ec2/variables.tf

variable "name_prefix" {
  description = "Prefix to use for naming resources"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to place the EC2 instances in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EC2 instances"
  type        = list(string)
}

variable "instance_configs" {
  description = "List of instance configurations"
  type        = list(any)
}

variable "instance_type" {
  description = "Default EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances (if not provided, latest Amazon Linux 2023 will be used)"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with instances"
  type        = bool
  default     = false
}

variable "root_volume_type" {
  description = "EBS volume type for the root volume"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "EBS volume size for the root volume in GB"
  type        = number
  default     = 20
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}