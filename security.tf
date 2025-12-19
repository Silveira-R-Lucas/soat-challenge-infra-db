resource "aws_db_subnet_group" "soat_db" {
  name       = "soat-db-subnet-group"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Name = "SOAT DB Subnet Group"
  }
}

resource "aws_security_group" "rds" {
  name        = "soat-rds-sg"
  description = "Permite a conexao do cluster EKS com o RDS"
  vpc_id      = data.aws_vpc.soat_challenge.id

  ingress {
    description     = "Permite PostgreSQL vindo dos nos do EKS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [data.aws_security_group.eks_nodes.id]
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

resource "aws_security_group" "redis_sg" {
  name        = "soat-redis-sg"
  description = "Permite a conexao do cluster EKS com o Redis"
  vpc_id      = data.aws_vpc.soat_challenge.id

  ingress {
    from_port       = var.redis_port
    to_port         = var.redis_port
    protocol        = "tcp"
    security_groups = [data.aws_security_group.eks_nodes.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mongo_sg" {
  name        = "soat-mongo-sg"
  description = "Permite a conexao do cluster EKS com o Mongo"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [data.aws_security_group.eks_nodes.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}