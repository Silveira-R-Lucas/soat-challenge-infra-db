data "aws_vpc" "soat_challenge" {
  tags = {
    Name = "soat-challenge-vpc"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_security_group" "eks_nodes" {
  vpc_id = data.aws_vpc.soat_challenge.id
  tags = {
    "Name" = "soat-challenge-cluster-node"
  }
}