variable "name" {}
variable "description" { default = "" }
variable "schedule_expression" { default = null } # for cron
variable "event_pattern" { default = null }       # for service events
variable "enabled" { default = true }
variable "target_arn" {}
variable "target_id" { default = "default-target" }
variable "role_arn" { default = null } # Optional IAM role
variable "input" { default = null } # Raw input JSON
variable "input_path" { default = null }
variable "input_transformer" { default = null }
