packer {
  required_version = ">= 1.11.0"
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 1.4.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.1"
    }
    git = {
      source  = "github.com/ethanmdavidson/git"
      version = ">= 0.6.2"
    }
    cnspec = {
      source  = "github.com/mondoohq/cnspec"
      version = ">= 10.0.0"
    }
  }
}