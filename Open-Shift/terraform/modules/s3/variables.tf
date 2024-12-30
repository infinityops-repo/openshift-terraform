variable "cluster_name" {
  description = "Nome do cluster OpenShift"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "Região AWS onde o bucket será criado"
  type        = string
} 