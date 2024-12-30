locals {
  common_tags = {
    Environment = var.environment
    Project     = "OpenShift"
    Owner       = "Shift"
    ManagedBy   = "Terraform"
  }
}

# Cluster Role
resource "aws_iam_role" "openshift_cluster" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = local.common_tags
}

# Node Role
resource "aws_iam_role" "openshift_node" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = local.common_tags
}

# Cluster Policies
resource "aws_iam_role_policy" "cluster_policy" {
  name = "${var.cluster_name}-cluster-policy"
  role = aws_iam_role.openshift_cluster.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "elasticloadbalancing:*",
          "route53:*",
          "route53domains:*",
          "s3:*",
          "kms:*",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}

# Node Policies
resource "aws_iam_role_policy" "node_policy" {
  name = "${var.cluster_name}-node-policy"
  role = aws_iam_role.openshift_node.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:DeleteVolume"
        ]
        Resource = "*"
      }
    ]
  })
} 