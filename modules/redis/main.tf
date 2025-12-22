resource "aws_elasticache_subnet_group" "this" {
  name       = "soat-redis-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = "soat-redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = 1
  port                 = var.port
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids   = [var.security_group_id]
}