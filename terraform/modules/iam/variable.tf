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

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}
