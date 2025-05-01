# modules/ec2/outputs.tf

output "instance_ids" {
  description = "Map of instance names to instance IDs"
  value       = { for k, v in aws_instance.this : k => v.id }
}

output "instance_arns" {
  description = "Map of instance names to instance ARNs"
  value       = { for k, v in aws_instance.this : k => v.arn }
}

output "private_ips" {
  description = "Map of instance names to private IP addresses"
  value       = { for k, v in aws_instance.this : k => v.private_ip }
}

output "public_ips" {
  description = "Map of instance names to public IP addresses, if applicable"
  value       = { for k, v in aws_instance.this : k => v.public_ip }
}

output "instance_azs" {
  description = "Map of instance names to availability zones"
  value       = { for k, v in aws_instance.this : k => v.availability_zone }
}