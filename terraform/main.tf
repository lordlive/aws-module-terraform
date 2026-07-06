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
