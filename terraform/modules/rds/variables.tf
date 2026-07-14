variable "environment" {
  description = "The environment in which the application is being deployed"
  type        = string
}

#RDS
variable "env" {
  type        = string
  description = "Environment name (dev, qa, prod, etc.)"
}

variable "name" {
  type        = string
  description = "Name RDS instance"
}

variable "engine" {
  type        = string
  description = "The database engine to use"
}

variable "engine_version" {
  type        = string
  description = "The engine version to use"
}

variable "family" {
  type        = string
  description = "The family of the DB parameter group"
}

variable "major_engine_version" {
  type        = string
  description = "Specifies the major version of the engine that this option group should be associated with"
}

variable "instance_class" {
  type        = string
  description = "The instance type of the RDS instance"
}

variable "allocated_storage" {
  type        = string
  description = "The allocated storage in gigabytes"
}

variable "storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not."
}

variable "max_allocated_storage" {
  type        = number
  description = "Maximum storage value in gigabytes"
}

variable "db_username" {
  type        = string
  description = "Username for the master DB user."
}

variable "multi_az" {
  type        = bool
  description = "If the RDS instance is multi AZ enabled."
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted"
}

variable "database_subnets" {
  type        = list(string)
  description = "A list of VPC subnet IDs. Can be from existing resources or VPC module."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs. Can be from existing resources or VPC/EKS module."
}

variable "db_subnet_group_name" {
  type        = string
  description = "DB Subnet Group name. Can be from existing resources or VPC module."
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
}

variable "backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
}

variable "deletion_protection" {
  type        = bool
  description = "The database can't be deleted when this value is set to true."
}

variable "publicly_accessible" {
  type        = bool
  description = "Bool to control if instance is publicly accessible"
}

variable "port" {
  type        = string
  description = "The port on which the DB accepts connections"
}

variable "ssl_connection" {
  type        = string
  description = "SSL connection setting for RDS (0 = disabled, 1 = enabled)"
}

variable "iam_database_authentication_enabled" {
  type        = bool
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot when the DB instance is deleted"
}

variable "manage_master_user_password" {
  type        = bool
  description = "Whether to manage the master user password. If false, the password will be managed by the user"
}
