variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


# VPC variables removed as we're using the default VPC


variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "instance_type" {
  description = "EC2 instance type for the EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 5
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 3
}

variable "disk_size" {
  description = "Disk size in GB for worker nodes"
  type        = number
  default     = 50
}

variable "environment" {
  description = "Environment tag for all resources"
  type        = string
  default     = "dev"
}