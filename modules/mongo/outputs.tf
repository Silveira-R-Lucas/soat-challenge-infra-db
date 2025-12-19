output "endpoint" {
  value = aws_docdb_cluster.this.endpoint
}

output "port" {
  value = 27017
}

output "debug_private_subnets_inside_module" {
  value = var.private_subnets
}