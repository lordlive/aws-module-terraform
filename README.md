# AWS Module Terraform

A modular Terraform infrastructure-as-code project for provisioning and managing AWS cloud resources. This project uses a modular architecture to deploy a complete, production-ready AWS infrastructure including VPC, EKS Kubernetes clusters, RDS databases, S3 storage, and more.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Usage](#usage)
- [Available Modules](#available-modules)
- [Outputs](#outputs)
- [Environments](#environments)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Overview

This Terraform project provides a reusable, modular infrastructure stack for AWS deployments. It allows you to provision complete cloud environments with all necessary components in a consistent, version-controlled manner.

**Key Features:**

- ✅ Modular design for reusability and maintainability
- ✅ Multi-environment support (dev, qa, prod, staging, etc.)
- ✅ Automated Kubernetes cluster provisioning (Amazon EKS)
- ✅ Database infrastructure with RDS and subnet groups
- ✅ Containerized application support with ECR
- ✅ Load balancing with Application Load Balancer (ALB)
- ✅ Secure networking with VPC, subnets, and security groups
- ✅ IAM roles and policies management
- ✅ CI/CD pipeline integration (GitHub Actions workflows included)

## Architecture

The project implements a cloud architecture with the following components:

```
┌─────────────────────────────────────────────┐
│          AWS Cloud Infrastructure           │
├─────────────────────────────────────────────┤
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │      VPC with Public/Private Subnets   │  │
│  │  ┌─────────────┐     ┌─────────────┐  │  │
│  │  │    EKS      │     │    RDS      │  │  │
│  │  │  Cluster    │     │  Database   │  │  │
│  │  └─────────────┘     └─────────────┘  │  │
│  │  ┌─────────────┐     ┌─────────────┐  │  │
│  │  │    ALB      │     │  S3 Storage │  │  │
│  │  │  (Load Bal) │     │             │  │  │
│  │  └─────────────┘     └─────────────┘  │  │
│  │  ┌─────────────┐     ┌─────────────┐  │  │
│  │  │    ECR      │     │    IAM      │  │  │
│  │  │  Registry   │     │   Roles     │  │  │
│  │  └─────────────┘     └─────────────┘  │  │
│  │                                        │  │
│  └───────────────────────────────────────┘  │
│                                             │
└─────────────────────────────────────────────┘
```

## Prerequisites

Before you begin, ensure you have the following installed:

### Required

- **Terraform** >= 1.0 - [Install Terraform](https://www.terraform.io/downloads)
- **AWS CLI** >= 2.0 - [Install AWS CLI](https://aws.amazon.com/cli/)
- **AWS Account** with appropriate permissions

### Optional

- **kubectl** - For managing Kubernetes clusters (if using EKS)
- **Helm** >= 3.0 - For Kubernetes package management
- **Git** - For version control

### AWS Permissions

Ensure your AWS credentials have permissions for:

- EC2 (VPC, Subnets, Security Groups, NAT Gateways)
- EKS (Cluster, Node Groups)
- RDS (DB Instances, Subnet Groups)
- S3 (Buckets, Objects)
- ECR (Repositories)
- IAM (Roles, Policies)
- ALB (Load Balancers)

## Project Structure

```
aws-module-terraform/
├── README.md                          # This file
├── LICENSE                            # License information
├── terraform.tfstate                  # Terraform state file
├── terraform/
│   ├── main.tf                        # Main configuration and module calls
│   ├── variables.tf                   # Input variable definitions
│   ├── outputs.tf                     # Output value definitions
│   ├── versions.tf                    # Terraform and provider versions
│   ├── data.tf                        # Data source definitions
│   ├── dev.auto.tfvars               # Development environment variables (auto-loaded)
│   ├── terraform.tfstate              # Terraform state
│   └── modules/                       # Reusable Terraform modules
│       ├── vpc/                       # VPC and networking module
│       │   ├── vpc.tf
│       │   ├── sg.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── eks/                       # EKS Kubernetes cluster module
│       │   ├── eks.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── rds/                       # RDS database module
│       │   ├── rds.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── s3/                        # S3 storage module
│       │   ├── s3.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── ecr/                       # ECR container registry module
│       │   ├── ecr.tf
│       │   ├── locals.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── alb/                       # Application Load Balancer module
│       │   ├── alb.tf
│       │   ├── acm.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── iam/                       # IAM roles and policies module
│           ├── iam.tf
│           ├── iam_policy.json
│           ├── variable.tf
│           └── outputs.tf
└── .github/
    └── workflows/                     # GitHub Actions CI/CD workflows
        ├── deploy-dev.yml
        ├── deploy-test.yml
        ├── destroy-dev.yml
        └── destroy-test.yml
```

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/lordlive/aws-module-terraform.git
cd aws-module-terraform
```

### 2. Configure AWS Credentials

```bash
# Option 1: Using AWS CLI
aws configure

# Option 2: Using environment variables
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="eu-central-1"
```

### 3. Initialize Terraform

```bash
cd terraform
terraform init
```

This command:

- Downloads required providers and modules
- Initializes the backend for state management
- Prepares the working directory

### 4. Plan the Infrastructure

```bash
# Review what will be created
terraform plan -out=tfplan

# Or for a specific environment
terraform plan -var-file="dev.auto.tfvars" -out=tfplan
```

### 5. Apply the Configuration

```bash
# Create the infrastructure
terraform apply tfplan

# Or apply directly
terraform apply
```

### 6. Retrieve Outputs

```bash
# Display all outputs
terraform output

# Get specific output
terraform output eks_cluster_id
```

## Configuration

### Variables

The project uses `.tfvars` files for configuration. Key variables include:

#### Global Variables

```hcl
app_name    = "aws-module"      # Application name
env         = ["dev"]           # List of environments to provision
region      = "eu-central-1"    # AWS region
environment = "dev"             # Current environment
```

#### VPC Configuration

```hcl
vpc_name              = "cloud-vpc"           # VPC name
vpc_cidr              = "10.0.0.0/20"         # VPC CIDR block
vpc_private_subnets   = ["10.0.0.0/24", "10.0.1.0/24"]
vpc_public_subnets    = ["10.0.2.0/24", "10.0.3.0/24"]
vpc_database_subnets  = ["10.0.4.0/24", "10.0.5.0/24"]
vpc_enable_nat_gateway     = true
vpc_one_nat_gateway_per_az = true
```

#### EKS Configuration

```hcl
cluster_name     = "eks-alpha-dev"    # Cluster name
cluster_version  = "1.36"             # Kubernetes version
node_name        = "node-alpha"       # Node group name
min_size         = 1                  # Minimum nodes
max_size         = 3                  # Maximum nodes
desired_size     = 1                  # Desired nodes
disk_size        = 20                 # Node root disk size (GB)
```

#### S3 Configuration

```hcl
bucket_name = "dev-bucket"   # S3 bucket name
```

### Environment Variables

Create environment-specific `.tfvars` files:

- `dev.auto.tfvars` - Development environment (auto-loaded)
- `test.auto.tfvars` - Testing environment
- `prod.auto.tfvars` - Production environment

## Usage

### Common Commands

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format Terraform files
terraform fmt -recursive

# Plan changes
terraform plan

# Apply configuration
terraform apply

# Destroy infrastructure
terraform destroy

# Show current state
terraform state show
terraform state list

# Refresh state
terraform refresh

# Get outputs
terraform output
terraform output -json
```

### Working with Multiple Environments

```bash
# Deploy to development
terraform apply -var-file="dev.auto.tfvars"

# Deploy to production
terraform apply -var-file="prod.auto.tfvars"

# Destroy development environment
terraform destroy -var-file="dev.auto.tfvars"
```

### Using Terraform Workspaces (Alternative)

```bash
# Create a new workspace
terraform workspace new dev
terraform workspace new prod

# Switch workspaces
terraform workspace select dev
terraform workspace select prod

# List workspaces
terraform workspace list
```

## Available Modules

### VPC Module

**Location:** `./modules/vpc`

Provisions networking infrastructure including:

- VPC with configurable CIDR blocks
- Public, private, and database subnets across multiple AZs
- Internet Gateway for public internet access
- NAT Gateways for private subnet outbound access
- Route tables and route associations
- Security groups for ALB

**Key Variables:**

- `vpc_cidr`, `vpc_private_subnets`, `vpc_public_subnets`
- `vpc_enable_nat_gateway`, `vpc_one_nat_gateway_per_az`
- `vpc_enable_dns_hostnames`, `vpc_enable_dns_support`

### EKS Module

**Location:** `./modules/eks`

Provisions Amazon Elastic Kubernetes Service (EKS):

- EKS control plane
- Managed node groups
- IAM roles and policies for cluster and nodes
- Security groups for cluster communication
- OIDC provider for IRSA (IAM Roles for Service Accounts)

**Key Variables:**

- `cluster_name`, `cluster_version`
- `instance_types`, `min_size`, `max_size`, `desired_size`
- `create_iam_role`, `create_node_iam_role`

### RDS Module

**Location:** `./modules/rds`

Provisions Relational Database Service:

- RDS database instances
- Database subnet groups
- Security groups for database access
- Backup and maintenance configuration

**Key Variables:**

- Database engine and version
- Instance type and storage configuration
- Multi-AZ deployment options

### S3 Module

**Location:** `./modules/s3`

Provisions S3 storage:

- S3 buckets with versioning
- Access control and encryption
- Lifecycle policies
- Storage class options

**Key Variables:**

- `bucket_name` - Bucket name (must be globally unique)
- Encryption and access control settings

### ECR Module

**Location:** `./modules/ecr`

Provisions Elastic Container Registry:

- Docker image repositories
- Access policies
- Lifecycle policies for image retention
- Repository encryption

### ALB Module

**Location:** `./modules/alb`

Provisions Application Load Balancer:

- Load balancer configuration
- Target groups
- Listeners and rules
- SSL/TLS certificates (ACM integration)

### IAM Module

**Location:** `./modules/iam`

Manages Identity and Access Management:

- IAM roles for services
- IAM policies and permissions
- Trust relationships
- Service-linked roles

## Outputs

The project provides the following outputs:

### VPC Outputs

- `vpc_id` - VPC identifier
- `vpc_cidr_block` - CIDR block of the VPC
- `private_subnets` - IDs of private subnets
- `public_subnets` - IDs of public subnets
- `database_subnets` - IDs of database subnets
- `nat_public_ips` - Public IPs of NAT Gateways
- `azs` - List of availability zones

### EKS Outputs

- `eks_cluster_id` - EKS cluster ID
- `eks_cluster_arn` - EKS cluster ARN
- `eks_cluster_name` - EKS cluster name
- `eks_cluster_endpoint` - EKS API endpoint
- `eks_cluster_oidc_issuer_url` - OIDC issuer URL
- `eks_oidc_provider_arn` - OIDC provider ARN
- `eks_asg_name` - Autoscaling group name

### Other Outputs

- `database_subnets_name` - Database subnet group names
- `elasticache_subnets` - ElastiCache subnet IDs
- `alb_security_group_id` - ALB security group ID

View all outputs:

```bash
terraform output
terraform output -json > outputs.json
```

## Environments

The project supports multiple environments out of the box:

### Development (`dev`)

- Minimal resources for cost efficiency
- Single NAT Gateway
- Smaller instance types
- Daily backups

### Testing (`test`)

- Mid-tier resources
- Multi-AZ setup
- Standard instance types

### Production (`prod`)

- Full-featured setup
- Multi-AZ with redundancy
- Larger instance types
- High availability configuration

### Configuration by Environment

Each environment has its own `.auto.tfvars` file:

```bash
dev.auto.tfvars      # Automatically loaded for dev
test.auto.tfvars     # Automatically loaded for test
prod.auto.tfvars     # Automatically loaded for prod
```

## Best Practices

### 1. State Management

```bash
# Always keep state files in version control (in git, encrypted)
# Use remote state for team collaboration (S3, Terraform Cloud)
# Lock state to prevent concurrent modifications
```

### 2. Code Organization

```bash
# Keep variables descriptive
# Use locals for computed values
# Modularize large configurations
# Use consistent naming conventions
```

### 3. Security

```bash
# Never commit secrets or credentials
# Use AWS IAM roles instead of access keys
# Enable encryption for all resources
# Implement least privilege IAM policies
# Use security groups to restrict access
```

### 4. Version Control

```bash
# Tag versions in git for infrastructure releases
# Document changes in git commits
# Use branches for different environments
# Review changes via pull requests before merging
```

### 5. Testing

```bash
# Validate Terraform syntax: terraform validate
# Format code consistently: terraform fmt
# Use terraform plan to review changes
# Test in non-production first
```

### 6. Monitoring and Maintenance

```bash
# Regularly update provider versions
# Review and update security policies
# Monitor resource utilization
# Clean up unused resources
```

## Troubleshooting

### Common Issues

#### 1. Authentication Error

```
Error: error configuring Terraform AWS Provider: no valid credential sources for Terraform AWS Provider found.
```

**Solution:** Configure AWS credentials using `aws configure` or set environment variables.

#### 2. Insufficient Capacity

```
Error: insufficient capacity in the availability zone
```

**Solution:** Change availability zones or instance types in the configuration.

#### 3. VPC CIDR Conflicts

```
Error: CIDR block already exists
```

**Solution:** Use unique CIDR blocks that don't conflict with existing VPCs.

#### 4. EKS API Not Accessible

```
Error: Unable to connect to EKS cluster API
```

**Solution:** Verify security group rules and cluster endpoint settings.

#### 5. State Lock Issues

```
Error: Error acquiring the state lock
```

**Solution:** Check if another process is using Terraform; manually unlock if needed: `terraform force-unlock <lock_id>`

### Debugging

```bash
# Enable debug logging
export TF_LOG=DEBUG
terraform plan

# Disable debug logging
unset TF_LOG

# Validate configuration
terraform validate

# Check current state
terraform state show

# List all resources in state
terraform state list

# Get specific resource details
terraform state show module.vpc
```

## CI/CD Integration

This project includes GitHub Actions workflows for automated deployments:

### Available Workflows

- `deploy-dev.yml` - Deploy to development environment
- `deploy-test.yml` - Deploy to testing environment
- `destroy-dev.yml` - Destroy development environment
- `destroy-test.yml` - Destroy testing environment

### Setup GitHub Actions

1. Add AWS credentials to GitHub Secrets:

   ```
   AWS_ACCESS_KEY_ID
   AWS_SECRET_ACCESS_KEY
   AWS_DEFAULT_REGION
   ```

2. Workflows trigger automatically on push/pull request events

3. Review workflow runs in GitHub Actions tab

## Contributing

We welcome contributions! Please follow these guidelines:

1. **Fork the repository**
2. **Create a feature branch** - `git checkout -b feature/your-feature`
3. **Make your changes** - Follow Terraform best practices
4. **Test thoroughly** - `terraform validate`, `terraform plan`
5. **Commit with clear messages** - `git commit -m "Add feature description"`
6. **Push to your fork** - `git push origin feature/your-feature`
7. **Create a Pull Request** - Include description of changes

### Code Style

- Use `terraform fmt` for formatting
- Add meaningful comments for complex configurations
- Document new variables in README
- Use descriptive names for resources

## License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

## Support

For issues, questions, or suggestions:

- Open an issue on GitHub
- Check existing issues for solutions
- Review AWS documentation for service-specific questions

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices)

---

**Last Updated:** 2026-07-13

**Version:** 1.0.0

**Maintainer:** lordlive
