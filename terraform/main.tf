module "vpc" {
  for_each = toset(var.env)
  source   = "./modules/vpc"

  # Common settings
  env          = each.value
  region       = var.region
  cluster_name = var.cluster_name

  # Network configuration
  vpc_name         = var.vpc_name
  vpc_cidr         = var.vpc_cidr
  azs              = var.vpc_azs
  private_subnets  = var.vpc_private_subnets
  public_subnets   = var.vpc_public_subnets
  database_subnets = var.vpc_database_subnets

  # DNS settings
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support

  # NAT Gateway configuration
  enable_nat_gateway     = var.vpc_enable_nat_gateway
  single_nat_gateway     = var.vpc_single_nat_gateway
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az
}

module "ecr" {
  source      = "./modules/ecr"
  environment = var.environment
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.app_name
}

module "eks" {
  for_each = toset(var.env)
  source   = "./modules/eks"

  # Common settings
  env          = each.value
  cluster_name = var.cluster_name
  region       = var.region

  # Cluster configuration
  cluster_version = var.cluster_version
  # cluster_enabled_log_types = var.cluster_enabled_log_types

  # IAM configuration
  #   create_iam_role       = var.create_iam_role
  #   iam_role_name_cluster = var.iam_role_name_cluster
  #   iam_role_arn_cluster  = var.iam_role_arn_cluster
  # enable_irsa                    = var.enable_irsa
  create_node_iam_role           = var.create_node_iam_role
  create_auto_mode_iam_resources = var.create_auto_mode_iam_resources
  # iam_role_arn_node              = var.iam_role_arn_node

  # Network settings - Switcher: if switcher_default_vpc = false, use existing IDs, if true use IDs from VPC module
  vpc_id          = module.vpc[each.value].vpc_id
  private_subnets = module.vpc[each.value].private_subnets

  # Security groups configuration
  create_node_security_group = var.create_node_security_group
  create_security_group      = var.create_security_group

  # Security groups switcher: if switcher_default_vpc = false, use existing security groups, if true use security groups from VPC module
  # security_group_list = var.switcher_default_vpc ? module.vpc[each.value].epam_security_groups : var.security_group_list

  # Endpoint access configuration
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  # Access control
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  eks_access_principal_arn                 = var.eks_access_principal_arn
  eks_access_policy_arn                    = var.eks_access_policy_arn

  # Node group configuration
  node_name      = var.node_name
  instance_types = var.instance_types
  min_size       = var.min_size
  max_size       = var.max_size
  desired_size   = var.desired_size
  disk_size      = var.disk_size

  # depends_on = [module.vpc]
}

# RDS

resource "aws_db_subnet_group" "rds" {
  name_prefix = "${var.app_name}-${var.environment}-db-subnet-group-"
  subnet_ids  = module.vpc[each.value].database_subnets

  tags = {
    Name = "${var.app_name}-${var.environment}-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name_prefix = "${var.app_name}-${var.environment}-sg-"
  description = "Security Group for ${var.app_name}-${var.environment} instances"
  vpc_id      = module.vpc[each.value].vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.app_name}-${var.environment}-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "rds" {
  ip_protocol       = "-1"
  cidr_ipv4         = module.vpc[each.value].vpc_cidr_block # "0.0.0.0/0"
  description       = "Allow egress"
  security_group_id = aws_security_group.rds.id
}

resource "aws_vpc_security_group_ingress_rule" "rds" {
  ip_protocol       = "tcp"
  cidr_ipv4         = module.vpc[each.value].vpc_cidr_block #"0.0.0.0/0"
  description       = "Allow ingress"
  security_group_id = aws_security_group.rds.id
  from_port         = var.rds_port
  to_port           = var.rds_port
}


module "rds" {
  for_each = toset(var.env)
  source   = "./modules/rds"

  # Common settings
  env         = each.value
  name        = "${each.value}-${var.app_name}"
  environment = var.environment

  # Database Engine settings
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  family               = var.rds_family
  major_engine_version = var.rds_major_engine_version

  # Instance configuration
  instance_class        = var.rds_instance_class
  storage_type          = var.rds_storage_type
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  multi_az              = var.rds_multi_az
  storage_encrypted     = var.rds_storage_encrypted
  publicly_accessible   = var.rds_publicly_accessible

  # Authentication and access
  db_username                         = var.rds_db_username
  port                                = var.rds_port
  ssl_connection                      = var.rds_ssl_connection
  iam_database_authentication_enabled = var.rds_iam_database_authentication_enabled
  manage_master_user_password         = var.rds_manage_master_user_password

  # Maintenance and backup
  maintenance_window  = var.rds_maintenance_window
  backup_window       = var.rds_backup_window
  deletion_protection = var.rds_deletion_protection
  skip_final_snapshot = var.rds_skip_final_snapshot

  # Network settings
  database_subnets       = data.aws_subnets.private_subnets.ids
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  depends_on = [
    aws_db_subnet_group.rds,
    aws_security_group.rds
  ]
}
