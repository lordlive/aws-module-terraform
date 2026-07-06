#VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = { for k, v in module.vpc : k => v.vpc_id }
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = { for k, v in module.vpc : k => v.vpc_cidr_block }
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = { for k, v in module.vpc : k => v.private_subnets }
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = { for k, v in module.vpc : k => v.public_subnets }
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = { for k, v in module.vpc : k => v.database_subnets }
}

output "database_subnets_name" {
  description = "List of database subnet group names"
  value       = { for k, v in module.vpc : k => v.database_subnets_name }
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = { for k, v in module.vpc : k => v.elasticache_subnets }
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = { for k, v in module.vpc : k => v.nat_public_ips }
}

output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = { for k, v in module.vpc : k => v.azs }
}

output "alb_security_group_id" {
  description = "Security group ID for the ALB"
  value       = module.vpc.alb_security_group_id
}

### ECR
output "repository_id" {
  value = module.ecr.repository_id
}

output "repository_name" {
  value = module.ecr.repository_name
}

output "repository_arn" {
  value = module.ecr.repository_arn
}

# EKS
output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = { for k, v in module.eks : k => v.cluster_id }
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = { for k, v in module.eks : k => v.cluster_endpoint }
}

output "eks_cluster_oidc_issuer_url" {
  description = "EKS Cluster oidc_issuer_url"
  value       = { for k, v in module.eks : k => v.cluster_oidc_issuer_url }
}

output "eks_oidc_provider_arn" {
  description = "EKS Cluster oidc_provider_arn"
  value       = { for k, v in module.eks : k => v.oidc_provider_arn }
}

output "eks_asg_name" {
  description = "EKS autoscaling group name for managed node group 'one' per env"
  value       = { for k, v in module.eks : k => v.eks_asg_name }
}

output "region" {
  description = "current_region"
  value       = var.region
}

# RDS
output "rds_db_host" {
  description = "The host address of the RDS instance"
  value       = { for k, v in module.rds : k => v.db_instance_address }
}

output "rds_db_username" {
  description = "The username for the RDS database"
  value       = { for k, v in module.rds : k => v.db_instance_username }
}

output "rds_db_password" {
  description = "The password for the RDS database"
  value       = { for k, v in module.rds : k => v.db_instance_password }
  sensitive   = true
}

output "rds_db_port" {
  description = "The port of the RDS instance"
  value       = { for k, v in module.rds : k => v.db_instance_port }
}
