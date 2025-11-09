terraform {
  required_version = ">= 1.10.0" # Replace with your installed version of Terraform
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
