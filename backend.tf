#provider "aws" {
#  profile    = "sandbox"
#  region     = "us-east-1"
#}
terraform {
  backend "s3" {
    bucket  = "terrak8-1121"
    key     = "terraform.tfstate"
    region  = "us-east-1"
  }
}