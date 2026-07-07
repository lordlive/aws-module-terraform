output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_id" {
  description = "EKS Cluster ID"
  value       = try(module.eks.cluster_id, module.eks.cluster_name, null)
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS Cluster Certificate Data"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_oidc_issuer_url" {
  description = "EKS Cluster oidc_issuer_url"
  value       = module.eks.cluster_oidc_issuer_url
}

output "oidc_provider_arn" {
  description = "EKS Cluster oidc_provider_arn"
  value       = module.eks.oidc_provider_arn
}

output "eks_asg_name" {
  description = "Autoscaling group name for managed node group 'one' (or null if absent)"
  value       = try(module.eks.eks_managed_node_groups["one"].node_group_autoscaling_group_names[0], null)
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "node_security_group_id" {
  description = "Security group ID attached to the EKS node group"
  value       = module.eks.node_security_group_id
}
