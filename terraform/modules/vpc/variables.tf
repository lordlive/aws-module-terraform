#VPC
variable "env" {
  type        = string
  description = "Environment name (dev, qa, prod, etc.)"
}

variable "region" {
  type        = string
  description = "Region where the VPC will be deployed."
}

variable "cluster_name" {
  type        = string
  description = "Base cluster name (will be combined with env in EKS module)"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "azs" {
  type        = list(string)
  description = "A list of availability zones in the region"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
}

variable "database_subnets" {
  type        = list(string)
  description = "A list of database subnets inside the VPC"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Should be true to enable DNS hostnames in the VPC"
}

variable "enable_dns_support" {
  type        = bool
  description = "Should be true to enable DNS support in the VPC"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Should be true to provision NAT Gateways for each private subnet"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Should be true to provision a single shared NAT Gateway across all private subnets"
}

variable "one_nat_gateway_per_az" {
  type        = bool
  description = "Should be true to provision one NAT Gateway per availability zone"
}
