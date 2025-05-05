variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

# Database configuration
variable "engine" {
  description = "Database engine type"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "Database instance type"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
}

variable "storage_type" {
  description = "Storage type for the database"
  type        = string
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
}

variable "username" {
  description = "Username for the database"
  type        = string
}

variable "password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "port" {
  description = "Database port"
  type        = number
}

# Network configuration
variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "multi_az" {
  description = "Whether to deploy a multi-AZ RDS instance"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether the database should be publicly accessible"
  type        = bool
}

# Parameter group
variable "parameter_group_name" {
  description = "Name of the DB parameter group to use"
  type        = string
}

# Backup and maintenance
variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}

variable "backup_window" {
  description = "Daily time range during which automated backups are created"
  type        = string
}

variable "maintenance_window" {
  description = "Weekly time range during which system maintenance can occur"
  type        = string
}

# Performance Insights
variable "performance_insights_enabled" {
  description = "Whether to enable Performance Insights"
  type        = bool
}

variable "performance_insights_retention_period" {
  description = "Performance Insights retention period in days (7 or 731)"
  type        = number
}

# Enhanced monitoring
variable "monitoring_interval" {
  description = "Monitoring interval in seconds (0, 1, 5, 10, 15, 30, 60)"
  type        = number
}

variable "monitoring_role_arn" {
  description = "ARN of the IAM role for enhanced monitoring (required if monitoring_interval > 0)"
  type        = string
}

# Deletion protection
variable "deletion_protection" {
  description = "Whether deletion protection is enabled"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when the instance is deleted"
  type        = bool
}

# Upgrade options
variable "auto_minor_version_upgrade" {
  description = "Whether to automatically upgrade minor engine versions"
  type        = bool
}

variable "allow_major_version_upgrade" {
  description = "Whether to allow major version upgrades"
  type        = bool
}

variable "apply_immediately" {
  description = "Whether to apply changes immediately or during the next maintenance window"
  type        = bool
}