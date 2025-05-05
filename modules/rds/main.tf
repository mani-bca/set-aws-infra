# RDS Instance
resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-subnet-group"
    }
  )
}

resource "aws_db_instance" "this" {
  identifier              = "${var.name_prefix}-db"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  storage_encrypted       = true
  
  # Database configuration
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  port                   = var.port
  
  # Network configuration
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  
  # Parameter group
  parameter_group_name = var.parameter_group_name
  
  # Backup and maintenance
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  
  # Performance Insights
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  
  # Enhanced monitoring
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_interval > 0 ? var.monitoring_role_arn : null
  
  # Deletion protection
  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot
  
  # Auto minor version upgrade
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  
  # Allow major version upgrade
  allow_major_version_upgrade = var.allow_major_version_upgrade
  
  # Apply changes immediately
  apply_immediately = var.apply_immediately
  
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-db"
    }
  )
}