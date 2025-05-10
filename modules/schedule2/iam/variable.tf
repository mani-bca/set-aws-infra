variable "name" {
  description = "Name of the IAM role/user/group"
  type        = string
}

variable "type" {
  description = "IAM entity type: role, user, or group"
  type        = string
  default     = "role"
}

variable "trust_policy_json" {
  description = "Trust relationship policy (only for IAM roles)"
  type        = string
  default     = null
}

variable "aws_managed_policy_arns" {
  description = "List of AWS-managed policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Map of policy name to file path of JSON policy document"
  type        = map(string)
  default     = {}
}
