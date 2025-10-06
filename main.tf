
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
  region               = "sa-east-1" 
  identifier           = var.db_name
  allocated_storage    = 50
  engine               = "postgres"                        
  instance_class       = var.db_instance_class
  db_name              = "soatdb_pg"                
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  publicly_accessible  = true                      
}
