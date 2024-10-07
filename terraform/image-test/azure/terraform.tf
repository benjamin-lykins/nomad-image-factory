terraform {
  cloud {
    organization = "hashiconf-2024"
    workspaces {
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.96.0"
    }
  }
}

provider "azurerm" {
  features {}
}
