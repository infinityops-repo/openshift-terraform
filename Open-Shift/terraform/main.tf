provider "aws" {
  region = var.region
}

# Módulo para configuração da VPC
module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# Módulo para configuração das instâncias EC2
module "ec2" {
  source              = "./modules/ec2"
  instance_type       = var.instance_type
  control_plane_count = var.control_plane_count
  worker_node_count   = var.worker_node_count
  ami                 = data.aws_ami.latest.id
  subnet_id           = module.vpc.private_subnet_id
  security_group_id   = module.security_groups.allow_http_https
}

# Módulo para configuração dos grupos de segurança
module "security_groups" {
  source   = "./modules/security_groups"
  vpc_id   = module.vpc.vpc_id
}

# Módulo para configuração de armazenamento
module "storage" {
  source              = "./modules/storage"
  worker_node_count   = var.worker_node_count
  ebs_volume_size     = var.ebs_volume_size
  availability_zone   = var.availability_zone
  worker_node_ids     = module.ec2.worker_node_ips
}

# Módulo para configuração de monitoramento
module "monitoring" {
  source = "./modules/monitoring"
}

# Módulo para configuração de IAM roles e policies
module "iam" {
  source = "./modules/iam"
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]  # Ou o ID do proprietário da AMI que você deseja usar
} 