terraform {
  backend "s3" {
    bucket         = ""
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}