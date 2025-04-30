provider "aws" {
  region     = var.region
  access_key = "AKIAU6GDURQVX6ALEIDS"
  secret_key = "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"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Use the default VPC and subnets
  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids

  # Use specified IAM role name for the cluster
  iam_role_name = "eksClusterRole"

  # Skip OIDC provider
  enable_irsa = false

  # Disable CloudWatch logging
  cluster_enabled_log_types = []

  # Self-managed node groups
  self_managed_node_groups = {
    worker_group = {
      name            = "${var.cluster_name}-worker-group"
      instance_type   = var.instance_type
      min_size        = var.min_size
      max_size        = var.max_size
      desired_size    = var.desired_size
      key_name        = var.key_name
      bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

      # Use latest EKS-optimized AMI
      ami_id = var.ami_id
      
      # Instance tags
      tags = {
        Name = "${var.cluster_name}-worker"
      }
    }
  }

  # Configure aws-auth configmap
  manage_aws_auth_configmap = true

  tags = var.tags
}
