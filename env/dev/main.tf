provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Tag the default VPC and its subnets for EKS
resource "aws_ec2_tag" "vpc_tag" {
  resource_id = data.aws_vpc.default.id
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

# Tag each subnet for EKS
resource "aws_ec2_tag" "subnet_cluster_tag" {
  for_each    = toset(data.aws_subnets.default.ids)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_ec2_tag" "subnet_elb_tag" {
  for_each    = toset(data.aws_subnets.default.ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "subnet_internal_elb_tag" {
  for_each    = toset(data.aws_subnets.default.ids)
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids

  # Self-managed node groups
  self_managed_node_group_defaults = {
    instance_type                          = var.instance_type
    update_launch_template_default_version = true
    iam_role_additional_policies = [
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    ]
  }

  self_managed_node_groups = {
    worker_group = {
      name                = "worker-group"
      min_size            = var.min_size
      max_size            = var.max_size
      desired_size        = var.desired_size
      bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            delete_on_termination = true
            volume_size           = var.disk_size
            volume_type           = "gp3"
          }
        }
      }

      tags = {
        Environment = var.environment
        Terraform   = "true"
      }
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# Create IAM role for EKS service account
module "iam_assumable_role_admin" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "~> 4.0"
  create_role                   = true
  role_name                     = "eks-service-account-role"
  provider_url                  = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  role_policy_arns              = ["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:aws-node"]
}