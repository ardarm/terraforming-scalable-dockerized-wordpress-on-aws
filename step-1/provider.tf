provider "aws" {
    region = "ap-southeast-1"
    profile = "arisd"
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}
