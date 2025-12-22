terraform {
  backend "s3" {
    bucket         = "soat-challenge-bucket"
    key            = "soat/challenge/database/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "terraform-db-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "soat_db" {
  identifier           = var.db_name
  allocated_storage    = 20
  engine               = "postgres"
  instance_class       = var.db_instance_class
  db_name              = "soatdb_pg"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true

  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.soat_db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
}

module "redis" {
  source            = "./modules/redis"
  private_subnets   = data.aws_subnets.private.ids
  node_type         = var.redis_node_type
  port              = var.redis_port
  security_group_id = aws_security_group.redis_sg.id
}

module "mongo" {
  source                  = "./modules/mongo"
  private_subnets         = data.aws_subnets.private.ids
  username                = var.mongo_username
  password                = var.mongo_password
  security_group_id       = aws_security_group.mongo_sg.id
  vpc_id                  = data.aws_vpc.soat_challenge.id
  vpc_security_group_id  = aws_security_group.mongo_sg.id
}