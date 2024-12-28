variable "instance_type" {
  description = "Tipo de instância para os nós"
  type        = string
}

variable "control_plane_count" {
  description = "Número de instâncias para o nó de controle"
  type        = number
}

variable "worker_node_count" {
  description = "Número de instâncias para os nós de trabalho"
  type        = number
}

variable "ami" {
  description = "AMI a ser usada para as instâncias"
  type        = string
}

variable "subnet_id" {
  description = "ID da sub-rede onde as instâncias serão lançadas"
  type        = string
}

variable "security_group_id" {
  description = "ID do grupo de segurança a ser associado às instâncias"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs das subnets públicas"
  type        = list(string)
}

variable "cluster_name" {
  description = "Nome do cluster OpenShift"
  type        = string
}

variable "iam_role_name" {
  description = "Nome do IAM role para as instâncias"
  type        = string
}

variable "key_name" {
  description = "Nome do key pair para SSH"
  type        = string
} 