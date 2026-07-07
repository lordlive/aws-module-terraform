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

#EKS
variable "cluster_name" {
  type        = string
  description = "Cluster name."
  default     = "test-aws-eks"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version to use for the EKS cluster."
  default     = "1.36"
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

# RDS
# variable "rds_name" {
#   type        = string
#   description = "Name RDS instance"
#   default     = "rds"
# }

variable "rds_engine" {
  type        = string
  description = "The database Engine to use"
  default     = "postgres"
}

variable "rds_engine_version" {
  type        = string
  description = "The database Engine version"
  default     = "15.14"
}

variable "rds_family" {
  type        = string
  description = "The family of the DB parameter group"
  default     = "postgres15"
}

variable "rds_major_engine_version" {
  type        = string
  description = "Specifies the major of the engine that this group should associated with"
  default     = "15"
}

variable "rds_instance_class" {
  type        = string
  description = "The instance type of the RDS instance"
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  type        = string
  description = "The allocate storage in gigabytes"
  default     = "10"
}

variable "rds_storage_type" {
  type        = string
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not."
  default     = "gp2"
}
variable "rds_max_allocated_storage" {
  type        = number
  description = "Maximum storage value in gigabytes"
  default     = 20
}

variable "rds_db_username" {
  type        = string
  description = "Username for the master DB user."
  default     = "adminuser"
}

variable "rds_multi_az" {
  type        = bool
  description = "If the RDS instance is multi AZ enabled."
  default     = false
}

variable "rds_storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB instance is encrypted"
  default     = true
}

# variable "rds_database_subnets" {
#   type        = list(string)
#   description = "A list of existing VPC subnet IDs for RDS database subnets (used when switcher_default_vpc = false). Example: [\"subnet-0fa48b12b28dff567\", \"subnet-07891652014e5f78a\"]"
# }

variable "rds_db_subnet_group_name" {
  type        = string
  description = "Existing DB Subnet Group name for RDS (used when switcher_default_vpc = false). Example: \"postgres-dev-subnet-group\". If empty, subnet group will be created automatically from rds_database_subnets."
  default     = ""
}

variable "rds_vpc_security_group_ids" {
  type        = list(string)
  description = "List of existing VPC security group IDs for RDS (used when switcher_default_vpc = false). Example: [\"sg-043687485bc89e127\", \"sg-0f874a1c0324d0a8a\"]"
  default     = [""]
}

variable "rds_maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = "Mon:00:00-Mon:03:00"
}

variable "rds_backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default     = "03:00-06:00"
}

variable "rds_deletion_protection" {
  type        = bool
  description = "The database can't be deleted when this value is set to true."
  default     = false
}

variable "rds_publicly_accessible" {
  type        = bool
  description = "Bool to control if instance is publicly accessible"
  default     = false
}

variable "rds_port" {
  type        = string
  description = "The port on which the DB accepts connections"
  default     = "5432"
}

variable "rds_ssl_connection" {
  type        = string
  description = "SSL connection setting for RDS (0 = disabled, 1 = enabled)"
  default     = "0"
}

variable "rds_iam_database_authentication_enabled" {
  type        = bool
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  default     = false
}

variable "rds_skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot when the RDS instance is deleted"
  default     = true
}

variable "rds_manage_master_user_password" {
  type        = bool
  description = "Whether to manage the master user password. If false, the password will be managed by the user"
  default     = false
}
