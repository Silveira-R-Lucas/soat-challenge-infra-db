data "aws_vpc" "soat_challenge" {
  tags = {
    Name = "soat-challenge-vpc"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.soat_challenge.id]
  }

  tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

data "aws_security_group" "eks_cluster" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.soat_challenge.id]
  }

  tags = {
    "eks:cluster-name" = "soat-challenge-cluster"
  }
}