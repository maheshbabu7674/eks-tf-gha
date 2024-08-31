# main.tf

terraform {
  backend "s3" {
    bucket         = "eksterraformtatebucket"      # Replace with your S3 bucket name
    key            = "eks/terraform.tfstate"          # State file path within the S3 bucket
    region         = "ap-south-1"                     # AWS region where the S3 bucket is located
    dynamodb_table = "ekslockmaster"        # DynamoDB table for state locking
    encrypt        = true                             # Encrypt the state file at rest
  }
}

# Include provider configurations
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.1"
    }
  }

provider "aws" {
  region = var.region
  version = "~> 3.0"
}

# VPC Configuration
module "vpc" {
  source = "./vpc"

  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
}

# EKS Cluster Configuration
module "eks" {
  source           = "./eks"
  cluster_name     = var.cluster_name
  node_group_name  = var.node_group_name
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

# Outputs
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}
