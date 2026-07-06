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
