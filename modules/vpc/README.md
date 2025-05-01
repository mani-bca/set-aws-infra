Three public subnets and three private subnets - Each in different availability zones
Optional NAT Gateway - Can be disabled by default and enabled when needed
Proper routing - Internet Gateway for public subnets and NAT Gateway (when enabled) for private subnets

Key Features

Configurable NAT Gateway: By default, the NAT Gateway is disabled (create_nat_gateway = false), making it perfect for applications that only need public subnets. You can enable it when needed.
Multi-AZ Setup: Subnets are distributed across three availability zones for high availability.
Customizable CIDR Blocks: You can customize all CIDR ranges for VPC and subnets.
Comprehensive Outputs: The module provides all necessary outputs for integration with other resources.

How to Use

Basic Usage (NAT Gateway Disabled):

'''hcl
terraformmodule "vpc" {
  source = "./path/to/vpc-module"
  
  name = "prod-vpc"
  # Using defaults for everything else (NAT Gateway disabled)
}
'''

With NAT Gateway Enabled:

'''hcl
terraformmodule "vpc" {
  source = "./path/to/vpc-module"
  
  name = "prod-vpc"
  create_nat_gateway = true
}
'''

Fully Customized:

'''hcl
terraformmodule "vpc" {
  source = "./path/to/vpc-module"
  
  name = "custom-vpc"
  vpc_cidr = "172.16.0.0/16"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnet_cidrs = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  private_subnet_cidrs = ["172.16.11.0/24", "172.16.12.0/24", "172.16.13.0/24"]
  create_nat_gateway = true
}
'''