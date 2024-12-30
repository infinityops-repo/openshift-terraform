# Volumes EBS para os workers
resource "aws_ebs_volume" "worker_storage" {
  count             = var.worker_node_count
  availability_zone = aws_instance.worker[count.index].availability_zone
  size              = var.ebs_volume_size
  type              = "gp3"
  encrypted         = true
  
  tags = merge(local.common_tags, {
    Name = "${var.cluster_name}-worker-volume-${count.index + 1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  })
}

# Attachments dos volumes aos workers
resource "aws_volume_attachment" "worker_volume_attachment" {
  count       = var.worker_node_count
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.worker_storage[count.index].id
  instance_id = aws_instance.worker[count.index].id
} 