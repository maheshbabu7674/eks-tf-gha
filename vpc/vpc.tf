resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.cluster_name}-public-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.cluster_name}-igw"
  }
}
