resource "aws_iam_role" "openshift_role" {
  name = "openshift_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_policy" "openshift_policy" {
  name        = "openshift_policy"
  description = "Policy for OpenShift EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "cloudwatch:*",
          "logs:*",
          "iam:PassRole",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_openshift_policy" {
  policy_arn = aws_iam_policy.openshift_policy.arn
  role       = aws_iam_role.openshift_role.name
}

resource "aws_iam_role_policy" "openshift_node_policy" {
  name = "openshift_node_policy"
  role = aws_iam_role.openshift_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "elasticloadbalancing:*",
          "s3:*",
          "route53:*",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
} 