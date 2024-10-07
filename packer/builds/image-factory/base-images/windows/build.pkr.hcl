
variable "platform" {
  type        = string
  description = "The list of sources to build."
  default     = env("PLATFORM")
}

locals {
  build_source = lookup(local.sources, var.platform, ["source.amazon-ebs.windows-full"])
  sources = {
    aws = ["source.amazon-ebs.windows-full"]
    azure = ["source.azure-arm.windows-full"]
    vsphere = ["source.vsphere-iso.windows-full"]
  }
}

//  BLOCK: build
//  Defines the builders to run, provisioners, and post-processors.

build {
  sources = local.build_source

  provisioner "cnspec" {
    on_failure      = "continue"
    score_threshold = 85
    sudo {
      active = true
    }
  }

  provisioner "powershell" {
    only = ["azure-arm.windows-full"]
    inline = [
      "Write-host '=== Azure image build completed successfully ==='",
      "Write-host '=== Generalising the image ... ==='",
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /generalize /oobe /quit",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }

    provisioner "powershell" {
      only   = ["vsphere-iso.windows-full"]
      execute_command = "powershell -Command \"& { $script }\""
      inline = [
        "Write-host '=== Beginning Sysprep ... ==='",
        "Start-Process",
        "-FilePath",
        "C:\\Windows\\System32\\Sysprep\\Sysprep.exe",
        "-ArgumentList",
        "/quit",
        "/generalize",
        "/mode:vm",
        "-Wait",
        "-NoNewWindow",
        "Write-host '=== Sysprep process completed ... ==='"
      ]
  }

  provisioner "powershell" {
    only = ["amazon-ebs.windows-full"]
    inline = [
      "& 'C:/Program Files/Amazon/EC2Launch/ec2launch' reset --block",
      "& 'C:/Program Files/Amazon/EC2Launch/ec2launch' sysprep --shutdown --block",
    ]
  }

  dynamic "hcp_packer_registry" {
    for_each = var.common_hcp_packer_registry_enabled ? [1] : []
    content {
      bucket_name = local.bucket_name
      description = local.bucket_description
      bucket_labels = {
        "os_family" : var.vm_guest_os_family,
        "os_name" : var.vm_guest_os_name,
        "os_version" : var.vm_guest_os_version,
      }
      build_labels = {
        "build_version" : local.build_version,
        "packer_version" : packer.version,
      }
    }
  }
}
