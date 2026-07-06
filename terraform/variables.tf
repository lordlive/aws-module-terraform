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


variable "cluster_name" {
  type        = string
  description = "Cluster name."
  default     = "pr-aws-eks"
}
