terraform {
  cloud {
    organization = "hashiconf-2024"
    workspaces {
    }
  }
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
    version = "~> 2.0" }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.96.0"
    }
  }
}

provider "vsphere" {
  allow_unverified_ssl = true
}

