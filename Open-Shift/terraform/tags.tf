locals {
  common_tags = {
    Environment = "production"
    Project     = "OpenShift"
    Owner       = "Shift"
  }
}

resource "aws_vpc" "main" {
  # ... (outros parâmetros)
  tags = merge(local.common_tags, {
    Name = "openshift-vpc"
  })
}

resource "aws_subnet" "public" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "openshift-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "openshift-private-subnet"
  }
}

resource "aws_instance" "control_plane" {
  count         = var.control_plane_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]
  tags = {
    Name = "openshift-control-plane-${count.index}"
  }
}

resource "aws_instance" "worker_node" {
  count         = var.worker_node_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]
  tags = {
    Name = "openshift-worker-node-${count.index}"
  }
}