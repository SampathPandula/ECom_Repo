provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_vpc" "ecommerce_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.ecommerce_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"  # First AZ
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.ecommerce_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"  # Second AZ
  map_public_ip_on_launch = true
}

resource "aws_eks_cluster" "ecommerce_eks" {
  name     = "ecommerce-cluster"
  role_arn = "arn:aws:iam::713881815267:role/EKS-Cluster-Role"

  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id] 
  }
}


