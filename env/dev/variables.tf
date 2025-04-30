variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "instance_type" {
  description = "Instance type for the worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "min_size" {
  description = "Minimum size of the worker node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the worker node group"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "Desired size of the worker node group"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "Key pair name to use for the instances"
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "AMI ID for the worker nodes. If not provided, the module will use the latest EKS-optimized AMI."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Terraform   = "true"
  }
}
