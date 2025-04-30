terraform {
  backend "s3" {
    bucket         = "terraform-state-bucketsa"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
  }
}
