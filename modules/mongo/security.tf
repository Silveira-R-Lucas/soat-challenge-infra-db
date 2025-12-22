resource "aws_security_group" "mongo_sg" {
  name   = "soat-mongo-sg"
  vpc_id = var.vpc_id
  
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "soat-mongo-sg"
  }
}
