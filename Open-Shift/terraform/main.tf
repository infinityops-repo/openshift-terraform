provider "aws" {
  region = var.region
}

# Módulo para configuração da VPC
module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  region       = var.region
  cluster_name = var.cluster_name
}

# Módulo para configuração das instâncias EC2
module "ec2" {
  source              = "./modules/ec2"
  instance_type       = var.instance_type
  control_plane_count = var.control_plane_count
  worker_node_count   = var.worker_node_count
  ami                 = data.aws_ami.latest.id
  subnet_id           = module.vpc.private_subnet_id
  vpc_id              = module.vpc.vpc_id
  vpc_cidr            = var.vpc_cidr
  public_subnet_ids   = module.vpc.public_subnet_ids
  cluster_name        = var.cluster_name
  key_name            = var.key_name
  iam_role_name       = module.iam.role_name
  ebs_volume_size     = var.ebs_volume_size
}

# Módulo para configuração do S3
module "s3" {
  source       = "./modules/s3"
  cluster_name = var.cluster_name
  environment  = var.environment
  region       = var.region
}

# Módulo para configuração de IAM roles e policies
module "iam" {
  source       = "./modules/iam"
  environment  = var.environment
  cluster_name = var.cluster_name
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]
} 