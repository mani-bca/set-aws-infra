resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.encryption_type == "KMS" ? var.kms_key : null
  }
  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = var.lifecycle_policy != null ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = var.lifecycle_policy
}

# Optional: Repository Policy
resource "aws_ecr_repository_policy" "this" {
  count      = var.repository_policy != null ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = var.repository_policy
}

# Optional: Add encryption configuration
# resource "aws_ecr_repository_encryption_configuration" "this" {
#   count        = var.encryption_type != "AES256" ? 1 : 0
#   repository_name = aws_ecr_repository.this.name
  
#   encryption_configuration {
#     encryption_type = var.encryption_type
#     kms_key         = var.kms_key
#   }
# }

# Optional: Add public repository functionality if needed
resource "aws_ecrpublic_repository" "this" {
  count           = var.create_public_repository ? 1 : 0
  repository_name = "${var.repository_name}-public"

  catalog_data {
    about_text        = var.about_text
    description       = var.description
    operating_systems = var.operating_systems
    architectures     = var.architectures
    usage_text        = var.usage_text
  }

  tags = var.tags
}