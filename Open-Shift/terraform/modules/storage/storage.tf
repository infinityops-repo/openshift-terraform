locals {
  common_tags = {
    Environment = "production"
    Project     = "OpenShift"
    Owner       = "Shift"
  }
}

resource "aws_ebs_volume" "worker_storage" {
  count             = var.worker_node_count
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  type              = "gp3"
  encrypted         = true
  tags = merge(local.common_tags, {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  })
}

resource "aws_volume_attachment" "worker_volume_attachment" {
  count          = var.worker_node_count
  device_name    = "/dev/sdh"  # Nome do dispositivo no Linux
  volume_id      = aws_ebs_volume.worker_storage[count.index].id
  instance_id    = var.worker_node_ids[count.index]  # Usando a variável passada
} 