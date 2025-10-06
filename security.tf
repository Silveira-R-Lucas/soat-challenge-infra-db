resource "aws_db_subnet_group" "soat_db" {
  name       = "soat-db-subnet-group"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name = "SOAT DB Subnet Group"
  }
}


resource "aws_security_group" "rds" {
  name        = "soat-db-sg"
  description = "Permite a conexão do cluster EKS com o RDS"
  vpc_id      = data.aws_vpc.soat_challenge.id

  ingress {
    description     = "Permite PostgreSQL vindo do EKS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    # A origem é o Security Group do cluster EKS
    security_groups = [data.aws_security_group.eks_cluster.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "soat-db-sg"
  }
}