locals {
  common_tags = {
    Environment = "production"
    Project     = "OpenShift"
    Owner       = "Shift"
  }
}

resource "aws_instance" "control_plane" {
  count         = var.control_plane_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]
  tags = merge(local.common_tags, {
    Name = "openshift-control-plane-${count.index}"
  })
}

resource "aws_instance" "worker_node" {
  count         = var.worker_node_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]
  tags = merge(local.common_tags, {
    Name = "openshift-worker-node-${count.index}"
  })
}

output "control_plane_ips" {
  value = aws_instance.control_plane[*].public_ip
}

output "worker_node_ips" {
  value = aws_instance.worker_node[*].public_ip
} 