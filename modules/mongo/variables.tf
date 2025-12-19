variable "private_subnets" {
  type = list(string)
}

variable "username" {}
variable "password" {
  sensitive = true
}
variable "security_group_id" {}

variable "vpc_id" {
  type        = string
  description = "VPC onde o Mongo será criado"
}