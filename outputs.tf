output "db_hostname" {
  description = "O hostname (endpoint) do banco de dados RDS."
  value       = aws_db_instance.soat_db.address
}

output "db_port" {
  description = "A porta do banco de dados RDS."
  value       = aws_db_instance.soat_db.port
}

output "db_username" {
  description = "O nome de usuário do banco de dados."
  value       = aws_db_instance.soat_db.username
  sensitive   = true
}

output "db_name_output" {
  description = "O nome do banco de dados criado."
  value       = aws_db_instance.soat_db.db_name
}

output "db_password" {
  description = "A senha do banco de dados."
  value       = aws_db_instance.soat_db.password
  sensitive   = true
}