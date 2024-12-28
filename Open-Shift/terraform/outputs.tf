output "vpc_id" {
  value = module.vpc.vpc_id
}

output "control_plane_ips" {
  value = module.ec2.control_plane_ips
}

output "worker_node_ips" {
  value = module.ec2.worker_node_ips
}

output "allow_http_https" {
  value = module.security_groups.allow_http_https
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

output "cluster_security_group_id" {
  value = module.security_groups.openshift_sg_id
} 