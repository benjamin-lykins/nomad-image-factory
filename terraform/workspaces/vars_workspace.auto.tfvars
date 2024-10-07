workspaces = {
  packer = {
    "packer-aws-ubuntu" = {
      project = "packer"
      tfvars = {
        region   = "us-east-2"
        platform = "aws"
      }
    }
    "packer-azure-ubuntu" = {
      project = "packer"
      tfvars = {
        region   = "eastus"
        platform = "azure"
      }
    }
    "packer-vsphere-ubuntu" = {
      project = "packer"
      tfvars = {
        region   = "Datacenter"
        platform = "vsphere"
      }
    }
    "packer-aws-rhel" = {
      project = "packer"
      tfvars = {
        region   = "us-east-2"
        platform = "aws"
      }
    }
    "packer-azure-rhel" = {
      project = "packer"
      tfvars = {
        region   = "eastus"
        platform = "azure"
      }
    }
    "packer-vsphere-rhel" = {
      project = "packer"
      tfvars = {
        region   = "Datacenter"
        platform = "vsphere"
      }
    }
    "packer-aws-windows" = {
      project = "packer"
      tfvars = {
        region   = "us-east-2"
        platform = "aws"
      }
    }
    "packer-azure-windows" = {
      project = "packer"
      tfvars = {
        region   = "eastus"
        platform = "azure"
      }
    }
    "packer-vsphere-windows" = {
      project = "packer"
      tfvars = {
        region   = "Datacenter"
        platform = "vsphere"
      }
    }
  }
}
