terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
  }
}