terraform {
  backend "s3" {
    key            = "terraform-aws/mincraft_server/terraform.tfstate"
    dynamodb_table = "terraform-statelock"
  }
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = var.aws_credentials_profile
  region  = var.aws_region
}
