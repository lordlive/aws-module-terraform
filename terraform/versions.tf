terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }

    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "~> 3.0"
    # }

  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment = var.environment
      managed_by  = "Terraform"
      app_name    = var.app_name
      region      = var.region
    }
  }
}

# provider "kubernetes" {
#   host                   = length(var.env) > 0 ? module.eks[var.env[0]].cluster_endpoint : ""
#   cluster_ca_certificate = length(var.env) > 0 ? base64decode(module.eks[var.env[0]].cluster_certificate_authority_data) : ""
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = length(var.env) > 0 ? ["eks", "get-token", "--cluster-name", "${var.cluster_name}-${var.env[0]}"] : []
#     command     = "aws"
#   }
# }

# Helm provider v3: kubernetes is a single nested object (use =, not block)
provider "helm" {
  kubernetes = {
    host                   = length(var.env) > 0 ? module.eks[var.env[0]].cluster_endpoint : ""
    cluster_ca_certificate = length(var.env) > 0 ? base64decode(module.eks[var.env[0]].cluster_certificate_authority_data) : ""
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = length(var.env) > 0 ? ["eks", "get-token", "--cluster-name", "${var.cluster_name}-${var.env[0]}"] : []
      command     = "aws"
    }
  }
}
