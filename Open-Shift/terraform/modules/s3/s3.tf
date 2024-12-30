locals {
  common_tags = {
    Environment = "production"
    Project     = "OpenShift"
    Owner       = "Shift"
  }
}

# Bucket para Registry do OpenShift
resource "aws_s3_bucket" "registry" {
  bucket = "${var.cluster_name}-registry-${data.aws_caller_identity.current.account_id}"
  
  tags = merge(local.common_tags, {
    Name = "${var.cluster_name}-registry"
  })
}

# Encryption para o bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "registry" {
  bucket = aws_s3_bucket.registry.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Versionamento para o bucket
resource "aws_s3_bucket_versioning" "registry" {
  bucket = aws_s3_bucket.registry.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Política de acesso ao bucket
resource "aws_s3_bucket_policy" "registry" {
  bucket = aws_s3_bucket.registry.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_role.openshift_registry.arn
        }
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy"
        ]
        Resource = [
          aws_s3_bucket.registry.arn,
          "${aws_s3_bucket.registry.arn}/*"
        ]
      }
    ]
  })
}

# IAM Role para o Registry
resource "aws_iam_role" "openshift_registry" {
  name = "${var.cluster_name}-registry-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = local.common_tags
}

# IAM Policy para o Registry
resource "aws_iam_role_policy" "registry" {
  name = "${var.cluster_name}-registry-policy"
  role = aws_iam_role.openshift_registry.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy"
        ]
        Resource = [
          aws_s3_bucket.registry.arn,
          "${aws_s3_bucket.registry.arn}/*"
        ]
      }
    ]
  })
}

# Dados da conta AWS atual
data "aws_caller_identity" "current" {} 