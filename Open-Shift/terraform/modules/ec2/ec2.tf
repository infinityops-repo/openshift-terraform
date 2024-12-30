locals {
  common_tags = {
    Environment = "production"
    Project     = "OpenShift"
    Owner       = "Shift"
  }
}

resource "aws_lb" "control_plane" {
  name               = "${var.cluster_name}-cp-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  tags = merge(local.common_tags, {
    Name = "${var.cluster_name}-control-plane-lb"
  })
}

resource "aws_lb_listener" "api_server" {
  load_balancer_arn = aws_lb.control_plane.arn
  port              = "6443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_server.arn
  }
}

resource "aws_lb_target_group" "api_server" {
  name     = "openshift-api-server"
  port     = 6443
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_iam_instance_profile" "openshift_profile" {
  name = "openshift_instance_profile"
  role = var.iam_role_name
}

resource "aws_instance" "control_plane" {
  count         = var.control_plane_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  
  vpc_security_group_ids = [aws_security_group.control_plane.id]
  
  root_block_device {
    volume_size = 100
    encrypted   = true
  }

  iam_instance_profile = aws_iam_instance_profile.openshift_profile.name
  key_name             = var.key_name

  tags = merge(local.common_tags, {
    Name = "${var.cluster_name}-control-plane-${count.index + 1}"
    Role = "control-plane"
  })
}

resource "aws_instance" "worker" {
  count         = var.worker_node_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  
  vpc_security_group_ids = [aws_security_group.worker.id]
  
  root_block_device {
    volume_size = 100
    encrypted   = true
  }

  iam_instance_profile = aws_iam_instance_profile.openshift_profile.name
  key_name             = var.key_name

  tags = merge(local.common_tags, {
    Name = "${var.cluster_name}-worker-${count.index + 1}"
    Role = "worker"
  })
}

output "control_plane_ips" {
  value = aws_instance.control_plane[*].public_ip
}

output "worker_node_ips" {
  value = aws_instance.worker[*].public_ip
} 