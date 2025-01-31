provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "ecommerce_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "EcommerceVPC"
  }
}

resource "aws_subnet" "subnet_ecommerce_01" {
  vpc_id                  = aws_vpc.ecommerce_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_ecommerce_01"
  }
}

resource "aws_subnet" "subnet_ecommerce_02" {
  vpc_id                  = aws_vpc.ecommerce_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet_ecommerce_02"
  }
}

resource "aws_eks_cluster" "EKS_ECom_Cluster" {
  name     = "ecommerce-cluster"
  role_arn = "arn:aws:iam::713881815267:role/EKS-Cluster-Role"

  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_ecommerce_01.id,
      aws_subnet.subnet_ecommerce_02.id
    ]  # Include two subnets
  }

  tags = {
    Name = "Ecommerce-Cluster"
  }
}
