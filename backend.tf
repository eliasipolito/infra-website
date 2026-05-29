terraform {
  backend "s3" {
    bucket = "infra-elias22"
    key = "site/terraform.tfstate"
    region = "us-east-2"
    encrypt = true
    
  }
}