#EKS
variable "env" {
  type        = string
  description = "Environment name (dev, qa, prod, etc.)"
}

variable "region" {
  type        = string
  description = "Region where the cluster will be deployed."
}

variable "cluster_name" {
  type        = string
  description = "Cluster name."
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version to use for the EKS cluster."
}

variable "vpc_id" {
  type        = string
  description = "VPC where the cluster and workers will be deployed. Can be from existing resources or VPC module."
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets to place the EKS cluster and workers within. Can be from existing resources or VPC module."
}

variable "create_iam_role" {
  type        = bool
  description = "Determines whether to create an IAM role for the EKS cluster."
}

# variable "iam_role_name_cluster" {
#   type        = string
#   description = "Name of the IAM role for the EKS cluster."
# }

# variable "iam_role_arn_cluster" {
#   type        = string
#   description = "ARN of the IAM role for the EKS cluster."
# }

# variable "enable_irsa" {
#   type        = bool
#   description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
# }

# variable "cluster_enabled_log_types" {
#   type        = list(any)
#   description = "List of log types to enable for the EKS cluster."
# }

variable "create_node_security_group" {
  type        = bool
  description = "Determines whether to create a security group for the EKS nodes."
}

variable "create_security_group" {
  type        = bool
  description = "Determines whether to create a security group for the EKS cluster."
}

variable "create_node_iam_role" {
  type        = bool
  description = "Determines whether to create an IAM role for the EKS nodes."
}

variable "create_auto_mode_iam_resources" {
  type        = bool
  description = "Determines whether to create auto mode IAM resources."
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

variable "enable_cluster_creator_admin_permissions" {
  type        = bool
  description = "Indicates whether to enable cluster creator admin permissions."
}

variable "node_name" {
  type        = string
  description = "Name of the EKS node group."
}

variable "instance_types" {
  type        = list(any)
  description = "Instance types to use for the EKS nodes."
}

variable "min_size" {
  type        = number
  description = "Minimum number of nodes in the EKS node group."
}

variable "max_size" {
  type        = number
  description = "Maximum number of nodes in the EKS node group."
}

variable "desired_size" {
  type        = number
  description = "Desired number of nodes in the EKS node group."
}

# variable "iam_role_arn_node" {
#   type        = string
#   description = "ARN of the IAM role for the EKS nodes."
# }

variable "disk_size" {
  type        = number
  description = "Disk size of the EKS nodes."
}

variable "eks_access_principal_arn" {
  type        = string
  description = "ARN of the principal for the EKS access."
}

variable "eks_access_policy_arn" {
  type        = string
  description = "ARN of the policy for the EKS access."
}

variable "alb_security_group_id" {
  type        = string
  description = "The Security Group for ALB"
}

# variable "security_group_list" {
#   type        = list(string)
#   description = "List of additional security group IDs to attach to EKS node groups"
# }






# variable "endpoint_public_access_cidrs" {
#   type        = list(string)
#   description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
#   default     = ["174.128.60.0/24", "195.56.119.208/28"]
# }


# variable "public_subnets" {
#   type        = list(string)
#   description = "A list of private subnets to place the EKS cluster and workers within."
#   default     = []
# }

# variable "subnets" {
#   type        = list(string)
#   description = "A list of private subnets to place the EKS cluster and workers within."
#   default     = []
# }

# variable "create_cluster_security_group" {
#   type    = bool
#   default = false
# }

# variable "security_group_id" {
#   type        = string
#   description = "The security group to associate"
#   default     = ""
# }

# variable "security_group_list" {
#   type        = list(string)
#   description = "The security group to associate (epams groups)"
#   default     = []
# }

# variable "iam_role_name_node" {
#   type    = string
#   default = "appway-eks-node-role"
# }





# variable "update_launch_template_default_version" {
#   type    = bool
#   default = true
# }



# variable "create_iam_instance_profile" {
#   type    = bool
#   default = false
# }

# variable "create_iam_role_node" {
#   type    = bool
#   default = false
# }





# variable "capacity_type" {
#   type    = string
#   default = "ON_DEMAND"
# }

# variable "use_mixed_instances_policy" {
#   type    = bool
#   default = true
# }

# variable "manage_aws_auth_configmap" {
#   type    = bool
#   default = true
# }

# variable "userarn" {
#   type    = string
#   default = "arn:aws:iam::835735088523:user/auto_epm-deps_aws_services@epam.com"
# }

# variable "username" {
#   type    = string
#   default = "auto_epm-deps_aws_services@epam.com"
# }

# variable "groups" {
#   type    = list(any)
#   default = ["system:masters"]
# }

# variable "aws_auth_accounts" {
#   type    = string
#   default = "835735088523"
# }

# /* variable "db_instance_password" {
#   type        = string
#   description = "RDS passowrd"
# } */
