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
