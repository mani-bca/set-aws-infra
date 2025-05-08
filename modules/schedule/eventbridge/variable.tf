# modules/eventbridge/variables.tf

variable "name_prefix" {
  description = "Prefix to be used for all resources"
  type        = string
  default     = "ec2-scheduler"
}

variable "schedule_group_name" {
  description = "Name of the EventBridge Scheduler schedule group"
  type        = string
  default     = "ec2-scheduler-group"
}

variable "schedules" {
  description = "Map of EventBridge Scheduler schedules to create"
  type = map(object({
    description        = string
    schedule_expression = string
    target_arn         = string
    role_arn           = string
    input              = optional(map(any))
  }))
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}