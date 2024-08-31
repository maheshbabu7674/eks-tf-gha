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
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_eks_cluster" "example" {
  name     = "example-cluster"
  role_arn  = aws_iam_role.eks_cluster_role.arn
  version   = "1.24" # Specify the EKS version

  vpc_config {
    subnet_ids = data.aws_subnet_ids.default.ids
  }

  tags = {
    Name = "example-cluster"
  }
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "example-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = data.aws_subnet_ids.default.ids
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = {
    Name = "example-node-group"
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "example-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role     = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role" "eks_node_role" {
  name = "example-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role     = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role     = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role     = aws_iam_role.eks_node_role.name
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

output "cluster_name" {
  value = aws_eks_cluster.example.name
}

output "node_group_name" {
  value = aws_eks_node_group.example.node_group_name
}
