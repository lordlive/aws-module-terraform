module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.7.0"

  # Common settings
  name   = var.cluster_name
  region = var.region

  # Cluster configuration
  kubernetes_version = var.cluster_version
  # enabled_log_types  = var.cluster_enabled_log_types

  # Network settings
  vpc_id                   = var.vpc_id
  control_plane_subnet_ids = var.private_subnets
  subnet_ids               = var.private_subnets

  # IAM configuration
  create_iam_role = var.create_iam_role
  # iam_role_name   = var.iam_role_name_cluster
  # iam_role_arn    = var.iam_role_arn_cluster
  # enable_irsa                    = var.enable_irsa
  create_node_iam_role           = var.create_node_iam_role
  create_auto_mode_iam_resources = var.create_auto_mode_iam_resources

  # Security groups configuration
  create_node_security_group = var.create_node_security_group
  create_security_group      = var.create_security_group
  # additional_security_group_ids = var.security_group_list

  # Endpoint access configuration
  endpoint_private_access = var.cluster_endpoint_private_access
  endpoint_public_access  = var.cluster_endpoint_public_access

  # Access control
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  # Cluster addons
  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute              = true
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
  }

  # Managed node groups configuration
  eks_managed_node_groups = {
    one = {
      # Node group basic settings
      name           = "${var.node_name}-${var.env}"
      instance_types = var.instance_types
      capacity_type  = "ON_DEMAND"

      # Scaling configuration
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      # IAM configuration
      create_iam_role = var.create_node_iam_role
      # iam_role_arn    = var.iam_role_arn_node
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
      # Security groups
      # vpc_security_group_ids = var.security_group_list

      # Storage configuration
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size = var.disk_size
            volume_type = "gp3"
          }
        }
      }
    }
  }

  # Security rule to pass traffic from ALB to pods
  node_security_group_additional_rules = {
    ingress_alb_to_pods = {
      description              = "Allow HTTP traffic from ALB to pods"
      protocol                 = "tcp"
      from_port                = 0
      to_port                  = 65535
      type                     = "ingress"
      source_security_group_id = var.alb_security_group_id # Security Group ID for ALB
    }
  }

  # Access entries configuration
  access_entries = {
    admin = {
      principal_arn = var.eks_access_principal_arn
      policy_associations = {
        admin = {
          policy_arn = var.eks_access_policy_arn
          access_scope = {
            type = "cluster"
          }
        }
      }
    },
    readonly = {
      principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/poweruser"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminViewPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}
