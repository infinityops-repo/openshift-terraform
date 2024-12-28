variable "vpc_id" {
  description = "ID da VPC onde o grupo de segurança será criado"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
} 