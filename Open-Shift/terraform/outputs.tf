output "vpc_id" {
  value = module.vpc.vpc_id
}

output "control_plane_ips" {
  value = module.ec2.control_plane_ips
}

output "worker_node_ips" {
  value = module.ec2.worker_node_ips
}

output "control_plane_sg_id" {
  value = module.ec2.control_plane_sg_id
}

output "worker_sg_id" {
  value = module.ec2.worker_sg_id
}

output "cluster_endpoint" {
  value = "https://${module.ec2.lb_dns_name}:6443"
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
} 