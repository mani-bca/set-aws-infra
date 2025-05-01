# modules/ec2/main.tf

terraform {
  required_version = ">= 1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  # Deployment configuration for each instance
  instance_configs = {
    for idx, config in var.instance_configs : config.name => merge(config, {
      subnet_id = element(var.subnet_ids, idx % length(var.subnet_ids))
    })
  }
}

# EC2 Instances
resource "aws_instance" "this" {
  for_each = local.instance_configs

  ami                         = local.ami_id
  instance_type               = lookup(each.value, "instance_type", var.instance_type)
  subnet_id                   = each.value.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = lookup(each.value, "user_data", null)
  user_data_replace_on_change = true
  iam_instance_profile        = var.iam_instance_profile

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
    
    tags = merge(
      var.tags,
      {
        "Name" = "${var.name_prefix}-${each.key}-root"
      }
    )
  }
  
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_devices
    
    content {
      device_name           = ebs_block_device.value.device_name
      volume_type           = lookup(ebs_block_device.value, "volume_type", "gp3")
      volume_size           = lookup(ebs_block_device.value, "volume_size", 10)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(ebs_block_device.value, "encrypted", true)
      
      tags = merge(
        var.tags,
        {
          "Name" = "${var.name_prefix}-${each.key}-${ebs_block_device.value.device_name}"
        }
      )
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.name_prefix}-${each.key}"
    },
    lookup(each.value, "tags", {})
  )
}