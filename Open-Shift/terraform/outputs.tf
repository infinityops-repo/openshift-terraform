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