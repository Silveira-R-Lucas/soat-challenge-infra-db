variable "db_name" {
  description = "O nome (identificador) da instância do banco de dados RDS."
  type        = string
  default     = "soat-challenge-db-postgres"
}

variable "db_instance_class" {
  description = "A classe (tamanho) da instância do banco de dados RDS."
  type        = string
  default     = "db.t3.micro"
}

variable "aws_region" {
  description = "A região da AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1"
}

variable "db_username" {
  description = "O nome de usuário para o banco de dados."
  type        = string
  default     = "postgres"
  sensitive   = true
}

variable "db_password" {
  description = "A senha para o banco de dados."
  type        = string
  sensitive   = true
}