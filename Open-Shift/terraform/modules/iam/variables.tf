# Este módulo pode não precisar de variáveis específicas, mas se necessário, adicione aqui. 

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster OpenShift"
  type        = string
} 