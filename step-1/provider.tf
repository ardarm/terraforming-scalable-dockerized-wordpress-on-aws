provider "aws" {
    access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
	region     = "${var.aws_region}"
    profile = "aris"
	
	version = "~> 1.28"
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}
