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