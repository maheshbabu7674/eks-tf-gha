# main.tf

# Include provider configurations
provider "aws" {
  region = var.region
}

# VPC Configuration
module "vpc" {
  source = "./vpc"

  vpc_cidr      = var.vpc_cidr
  public_subnets = var.public_subnets
}

# EKS Cluster Configuration
module "eks" {
  source           = "./eks"
  cluster_name     = var.cluster_name
  node_group_name  = var.node_group_name
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity

  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
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
