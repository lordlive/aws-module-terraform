# switcher_default_vpc = false
# create_vpc_endpoint  = true
app_name = "aws-module-terraform"

vpc_cidr             = "10.0.0.0/20"
vpc_azs              = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
vpc_private_subnets  = ["10.0.0.0/24", "10.0.1.0/24"]
vpc_public_subnets   = ["10.0.2.0/24", "10.0.3.0/24"]
vpc_database_subnets = ["10.0.4.0/24", "10.0.5.0/24"]

vpc_enable_dns_hostnames   = true
vpc_enable_dns_support     = true
vpc_enable_nat_gateway     = true
vpc_single_nat_gateway     = true
vpc_one_nat_gateway_per_az = false

env         = ["dev"]
region      = "eu-central-1"
environment = "dev"
# create_access_entries = true
