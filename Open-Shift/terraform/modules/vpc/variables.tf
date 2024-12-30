variable "vpc_cidr" {
  description = "CIDR block para a VPC"
  type        = string
}

variable "region" {
  description = "Região AWS onde a infraestrutura será criada"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster OpenShift"
  type        = string
} 