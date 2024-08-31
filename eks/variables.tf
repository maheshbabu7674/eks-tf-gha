variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the EKS nodes"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster is to be created"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the EKS nodes"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources created by the EKS module"
  type        = map(string)
  default     = {}
}

variable "node_volume_size" {
  description = "Size of the EBS volume for the EKS nodes"
  type        = number
  default     = 20
}

variable "node_disk_type" {
  description = "Type of EBS volume for the EKS nodes"
  type        = string
  default     = "gp2"
}
