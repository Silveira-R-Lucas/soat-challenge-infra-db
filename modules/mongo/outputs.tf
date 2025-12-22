output "endpoint" {
  value = aws_docdb_cluster.this.endpoint
}

output "port" {
  value = 27017
}

output "mongodb_username" {
  value     = aws_docdb_cluster.mongodb.master_username
  sensitive = true
}