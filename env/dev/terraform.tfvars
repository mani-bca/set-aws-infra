region          = "us-east-1"
cluster_name    = "eks-cluster"
cluster_version = "1.30"
instance_type   = "t2.medium"
min_size        = 2
max_size        = 3
desired_size    = 2
key_name        = "mykey" 

tags = {
  Environment = "dev"
  Project     = "eks-demo"
  Terraform   = "true"
}
