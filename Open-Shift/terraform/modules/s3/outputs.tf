output "registry_bucket_name" {
  description = "Nome do bucket S3 do registry"
  value       = aws_s3_bucket.registry.id
}

output "registry_bucket_arn" {
  description = "ARN do bucket S3 do registry"
  value       = aws_s3_bucket.registry.arn
}

output "registry_role_arn" {
  description = "ARN da role IAM do registry"
  value       = aws_iam_role.openshift_registry.arn
} 