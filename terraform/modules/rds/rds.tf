# Password generation for RDS instance
# To force password reset: terraform taint 'module.rds["dev"].random_password.password' && terraform apply
resource "random_password" "password" {
  length  = 16
  special = true
  # Exclude problematic characters that may cause issues in connection strings
  override_special = "!#$%&'()*+,-.:;?[]^_{|}~"
  # Ensure password has required character types
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.13.0"

  # Common settings
  identifier = var.name

  # Database engine configuration
  engine               = var.engine
  engine_version       = var.engine_version
  family               = var.family
  major_engine_version = var.major_engine_version

  # Instance configuration
  instance_class        = var.instance_class
  storage_type          = var.storage_type
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  multi_az              = var.multi_az
  storage_encrypted     = var.storage_encrypted
  publicly_accessible   = var.publicly_accessible

  # Authentication and access
  username                            = var.db_username
  port                                = var.port
  password                            = random_password.password.result
  manage_master_user_password         = var.manage_master_user_password # Use self-managed password from random_password
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  # Network settings
  subnet_ids             = var.database_subnets
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids

  # Maintenance and backup
  maintenance_window  = var.maintenance_window
  backup_window       = var.backup_window
  deletion_protection = var.deletion_protection
  skip_final_snapshot = var.skip_final_snapshot # If true, final snapshot will NOT be created automatically on deletion

  # Parameter group
  # parameter_group_name = aws_db_parameter_group.ssl-connection.name

}
