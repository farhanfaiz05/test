terraform {
  backend "s3" {
    bucket         = "farhan-g2-test-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}