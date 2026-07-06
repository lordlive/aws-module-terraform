# VPC
variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "env" {
  type        = list(string)
  description = "List of environments to provision (dev, qa, prod, etc.)"
  default     = ["dev"]
}

variable "environment" {
  description = "The environment in which the application is being deployed"
  type        = string
}

variable "region" {
  description = "The AWS Region"
}

#VPC
variable "vpc_name" {
  type        = string
  description = "VPC name (will be combined with env in VPC module: {vpc_name}-{env})"
  default     = "cloud-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "vpc_azs" {
  type        = list(string)
  description = "A list of availability zones in the region"
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
}

variable "vpc_database_subnets" {
  type        = list(string)
  description = "A list of database subnets inside the VPC"
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = true
}

variable "vpc_enable_dns_support" {
  type        = bool
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "vpc_enable_nat_gateway" {
  type        = bool
  description = "Should be true to provision NAT Gateways for each private subnet"
  default     = true
}

variable "vpc_single_nat_gateway" {
  type        = bool
  description = "Should be true to provision a single shared NAT Gateway across all private subnets"
  default     = false
}

variable "vpc_one_nat_gateway_per_az" {
  type        = bool
  description = "Should be true to provision one NAT Gateway per availability zone"
  default     = true
}

# S3
variable "bucket_name" {
  type        = string
  description = "S3 name"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name."
  default     = "pr-aws-eks"
}

#EKS
variable "cluster_name" {
  type        = string
  description = "Cluster name."
  default     = "test-aws-eks"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version to use for the EKS cluster."
  default     = "1.35"
}

# variable "create_iam_role" {
#   type        = bool
#   description = "Determines whether to create an IAM role for the EKS cluster."
#   default     = true
# }

# variable "iam_role_name_cluster" {
#   type        = string
#   description = "Name of the IAM role for the EKS cluster."
#   default     = "appway-eks-cluster-role"
# }

# variable "iam_role_arn_cluster" {
#   type        = string
#   description = "ARN of the IAM role for the EKS cluster."
#   default     = "arn:aws:iam::835735088523:role/appway-eks-cluster-role"
# }

variable "enable_irsa" {
  type        = bool
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  default     = false
}

variable "cluster_enabled_log_types" {
  type        = list(any)
  description = "List of log types to enable for the EKS cluster."
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "create_node_security_group" {
  type        = bool
  description = "Determines whether to create a security group for the EKS nodes."
  default     = true
}

variable "create_security_group" {
  type        = bool
  description = "Determines whether to create a security group for the EKS cluster."
  default     = true
}

variable "create_node_iam_role" {
  type        = bool
  description = "Determines whether to create an IAM role for the EKS nodes."
  default     = false
}

variable "create_auto_mode_iam_resources" {
  type        = bool
  description = "Determines whether to create auto mode IAM resources."
  default     = false
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  default     = true
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
  default     = true
}

variable "enable_cluster_creator_admin_permissions" {
  type        = bool
  description = "Indicates whether to enable cluster creator admin permissions."
  default     = true
}

variable "node_name" {
  type        = string
  description = "Name of the EKS node group."
  default     = "test"
}

variable "instance_types" {
  type        = list(any)
  description = "Instance types to use for the EKS nodes."
  default     = ["t3.small"] #["t2.small"]  #["m4.2xlarge"]
}

variable "min_size" {
  type        = number
  description = "Minimum number of nodes in the EKS node group."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of nodes in the EKS node group."
  default     = 1
}

variable "desired_size" {
  type        = number
  description = "Desired number of nodes in the EKS node group."
  default     = 1
}

# variable "iam_role_arn_node" {
#   type        = string
#   description = "ARN of the IAM role for the EKS nodes."
#   default     = "arn:aws:iam::835735088523:role/appway-eks-node-role"
# }

variable "disk_size" {
  type        = number
  description = "Disk size of the EKS nodes."
  default     = 100
}

variable "eks_access_principal_arn" {
  type        = string
  description = "ARN of the principal for the EKS access."
  default     = "arn:aws:iam::807291694811:user/admin"
}

variable "eks_access_policy_arn" {
  type        = string
  description = "ARN of the policy for the EKS access."
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}
