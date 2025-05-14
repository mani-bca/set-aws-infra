output "repository_url" {
  description = "The URL of the repository"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "The ARN of the repository"
  value       = aws_ecr_repository.this.arn
}

output "repository_registry_id" {
  description = "The registry ID where the repository was created"
  value       = aws_ecr_repository.this.registry_id
}

output "repository_name" {
  description = "The name of the repository"
  value       = aws_ecr_repository.this.name
}

output "public_repository_url" {
  description = "The URL of the public repository, if created"
  value       = var.create_public_repository ? aws_ecrpublic_repository.this[0].repository_uri : null
}

output "public_repository_arn" {
  description = "The ARN of the public repository, if created"
  value       = var.create_public_repository ? aws_ecrpublic_repository.this[0].arn : null
}