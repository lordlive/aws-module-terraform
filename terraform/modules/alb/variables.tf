variable "vpc_id" {
  type        = string
  description = "VPC id where the load balancer and other resources will be deployed"
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnets to associate with the load balancer"
}

variable "security_groups" {
  type        = list(string)
  description = "The security groups to attach to the load balancer."
}

variable "eks_asg_name" {
  type        = string
  description = "Name of ASG to associate with the ELB"
}

variable "certificate_arn" {
  type        = string
  description = "Certificate ARN for an Application Load Balancer"
  default     = "arn:aws:acm:eu-central-1:807291694811:certificate/586747aa-bdba-4796-8503-ad4d00793a8d"
}

variable "app_name" {
  type        = string
  description = "Application name to be using to name the resources"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name."
}
