output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
  description = "Endpoint of the RDS instance"
}