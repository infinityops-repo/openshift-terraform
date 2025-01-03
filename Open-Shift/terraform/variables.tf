variable "region" {
  description = "A região da AWS onde o cluster será provisionado"
  default     = "us-east-1"
}

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

variable "ebs_volume_size" {
  description = "Tamanho dos volumes EBS em GB"
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
  description = "ID da VPC onde o grupo de segurança será criado"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidade onde os recursos serão criados"
  type        = string
}

variable "cluster_name" {
  description = "Nome do cluster OpenShift"
  type        = string
  default     = "openshift-cluster"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "key_name" {
  description = "Nome do key pair para SSH"
  type        = string
  default     = null
}

variable "domain_name" {
  description = "Domain name para o cluster"
  type        = string
  default     = "example.com"
} 