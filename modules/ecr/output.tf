variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  type        = string
  default     = "MUTABLE"
  
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Image tag mutability must be either MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "lifecycle_policy" {
  description = "JSON formatted ECR lifecycle policy"
  type        = string
  default     = null
}

variable "repository_policy" {
  description = "JSON formatted repository policy"
  type        = string
  default     = null
}

variable "encryption_type" {
  description = "The encryption type for the repository. Valid values are AES256 or KMS"
  type        = string
  default     = "AES256"
  
  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "Encryption type must be either AES256 or KMS."
  }
}

variable "kms_key" {
  description = "The ARN of the KMS key to use when encryption_type is KMS"
  type        = string
  default     = null
}

variable "create_public_repository" {
  description = "Whether to create a public ECR repository"
  type        = bool
  default     = false
}

# Variables for public repository
variable "about_text" {
  description = "The About text for the public repository"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description for the public repository"
  type        = string
  default     = ""
}

variable "operating_systems" {
  description = "The operating systems supported by the public repository"
  type        = list(string)
  default     = []
}

variable "architectures" {
  description = "The architectures supported by the public repository"
  type        = list(string)
  default     = []
}

variable "usage_text" {
  description = "The usage text for the public repository"
  type        = string
  default     = ""
}