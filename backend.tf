terraform {
  backend "s3" {
    bucket = "s3-test-cicd-project"
    key = "terraform_state/terraform.tfstate"
    region = "us-east-1"
  }
}