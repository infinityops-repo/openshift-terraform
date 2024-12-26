resource "aws_ebs_volume" "data" {
  count             = var.worker_node_count
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  type              = "gp2"  # Tipo de volume (gp2, io1, etc.)
  tags = {
    Name = "openshift-worker-volume-${count.index}"
  }
}

resource "aws_volume_attachment" "worker_volume_attachment" {
  count          = var.worker_node_count
  device_name    = "/dev/sdh"  # Nome do dispositivo no Linux
  volume_id      = aws_ebs_volume.data[count.index].id
  instance_id    = var.worker_node_ids[count.index]  # Usando a variável passada
} 