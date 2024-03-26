terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }
  }
  backend "s3" {
    bucket = "devops-task-123"
    key    = "tf/devops-task"
    region = "eu-west-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}