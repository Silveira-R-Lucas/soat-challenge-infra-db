resource "aws_docdb_subnet_group" "this" {
  name       = "soat-mongo-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "soat-mongo-subnet-group"
  }
}

resource "aws_docdb_cluster" "this" {
  cluster_identifier      = "soat-mongo"
  engine                  = "docdb"
  master_username         = var.username
  master_password         = var.password
  skip_final_snapshot     = true
  db_subnet_group_name = aws_docdb_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.mongo_sg.id]
}

resource "aws_docdb_cluster_instance" "this" {
  count              = 1
  identifier         = "soat-mongo-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.this.id
  instance_class     = "db.t3.medium"
}