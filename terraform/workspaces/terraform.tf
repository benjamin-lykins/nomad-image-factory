terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.59.0"
    }
  }
  cloud {
    workspaces {
      name = "platform-control-ws"
    }
    hostname     = "app.terraform.io"
    organization = "hashiconf-2024"
  }
}

provider "tfe" {
  hostname     = var.tfe_hostname
  organization = var.organization
}
