variable "worker_node_count" {
  description = "Número de nós de trabalho para os quais os volumes EBS serão criados"
  type        = number
}

variable "ebs_volume_size" {
  description = "Tamanho dos volumes EBS em GB"
  type        = number
}

variable "availability_zone" {
  description = "Zona de disponibilidade onde os volumes EBS serão criados"
  type        = string
}

variable "worker_node_ids" {
  description = "IDs das instâncias dos nós de trabalho"
  type        = list(string)  # ou string, dependendo de como você deseja usar
}

variable "cluster_name" {
  description = "Nome do cluster OpenShift"
  type        = string
} 