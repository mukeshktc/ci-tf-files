provider "aws" {
  region = "us-east-1"
}

data "aws_iam_role" "s3" {
  name = "s3-test-role"
  }