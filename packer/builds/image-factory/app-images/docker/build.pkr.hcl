variable "platform" {
  type        = string
  description = "The list of sources to build."
  default     = env("PLATFORM")
}

locals {
  build_source = lookup(local.sources, var.platform, ["source.amazon-ebs.docker"])
  sources = {
    aws     = ["source.amazon-ebs.docker"]
    azure   = ["source.azure-arm.docker"]
    vsphere = ["source.vsphere-clone.docker"]
  }
}

build {
  sources = local.build_source

  provisioner "ansible" {
    user                   = var.build_username
    // galaxy_file            = "${path.cwd}/packer/playbooks/linux-requirements.yml"
    // galaxy_force_with_deps = true
    playbook_file          = "${path.cwd}/packer/playbooks/app-docker-playbook.yml"
    roles_path             = "${path.cwd}/packer/playbooks/roles"
    ansible_env_vars = [
      "ANSIBLE_CONFIG=${path.cwd}/packer/playbooks/ansible.cfg"
    ]
    extra_arguments = [
      "--extra-vars", "display_skipped_hosts=false",
      "--extra-vars", "enable_cloudinit=${var.vm_guest_os_cloudinit}",
      "--extra-vars", "build_username=${var.build_username}",
      "--extra-vars", "build_key='${var.build_key}'",
      "--extra-vars", "ansible_username=${var.ansible_username}",
      "--extra-vars", "ansible_key='${var.ansible_key}'",
      "--extra-vars", "platform=${source.type}",
    ]
  }

  provisioner "cnspec" {
  on_failure          = "continue"
  score_threshold     = 85
  sudo {
    active = true
  }
}

provisioner "shell" {
   only = ["azure-arm.docker"]
   execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
   inline = [
        "echo '*** Running Azure ARM specific provisioner ***'",
        "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
   ]
   inline_shebang = "/bin/sh -x"
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
