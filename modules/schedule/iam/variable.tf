# modules/iam/variables.tf

variable "name_prefix" {
  description = "Prefix to be used for all resources"
  type        = string
  default     = "ec2-scheduler"
}

variable "lambda_roles" {
  description = "Map of Lambda roles to create"
  type = map(object({
    description           = string
    additional_policy_arns = list(string)
  }))
  default = {
    "start-ec2" = {
      description = "Role for Lambda function to start EC2 instances"
      additional_policy_arns = []
    },
    "stop-ec2" = {
      description = "Role for Lambda function to stop EC2 instances"
      additional_policy_arns = []
    }
  }
}

variable "create_vpc_access_policy" {
  description = "Whether to create and attach a VPC access policy"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}