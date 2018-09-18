provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_intro_demo_bucket" {
  bucket = "terraform-intro-demo-bucket"
}
