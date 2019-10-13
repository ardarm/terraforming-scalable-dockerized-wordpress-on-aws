provider "aws" {
	region     = "${var.aws_region}"
}

terraform {
   backend "s3" {
    bucket = "wordpress-terraform"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}
