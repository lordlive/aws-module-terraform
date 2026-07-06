terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
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
