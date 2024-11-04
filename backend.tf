terraform {
  backend "s3" {
    bucket         = "farhan-g2-test-bucket2"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}