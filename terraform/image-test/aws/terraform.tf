terraform {
  cloud {
    organization = "hashiconf-2024"
    workspaces {
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.96.0"
    }
  }
}

provider "aws" {
}


