variable "private_subnets" {
  type = list(string)
}

variable "username" {}
variable "password" {
  sensitive = true
}
variable "security_group_id" {}