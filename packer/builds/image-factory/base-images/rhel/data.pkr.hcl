//  BLOCK: data
//  Defines the data sources.

data "git-repository" "cwd" {}

//  BLOCK: locals
//  Defines the local variables.

locals {
  build_by          = "Built by: HashiCorp Packer ${packer.version}"
  build_date        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_version     = data.git-repository.cwd.head
  build_description = "Version: ${local.build_version}\nBuilt on: ${local.build_date}\n${local.build_by}"
  iso_paths = {
    datastore       = "[${var.common_iso_datastore}] ${var.iso_datastore_path}/${var.iso_file}"
  }

  data_source_content = {
    "/ks.cfg" = templatefile("${abspath(path.root)}/data/ks.pkrtpl.hcl", {
      build_username           = var.build_username
      build_password           = var.build_password
      build_password_encrypted = var.build_password_encrypted
      rhsm_username            = var.rhsm_username
      rhsm_password            = var.rhsm_password
      vm_guest_os_language     = var.vm_guest_os_language
      vm_guest_os_keyboard     = var.vm_guest_os_keyboard
      vm_guest_os_timezone     = var.vm_guest_os_timezone
      vm_guest_os_cloudinit    = var.vm_guest_os_cloudinit
      network = templatefile("${abspath(path.root)}/data/network.pkrtpl.hcl", {
        device  = var.vm_network_device
        ip      = var.vm_ip_address
        netmask = var.vm_ip_netmask
        gateway = var.vm_ip_gateway
        dns     = var.vm_dns_list
      })
      storage = templatefile("${abspath(path.root)}/data/storage.pkrtpl.hcl", {
        device     = var.vm_disk_device
        swap       = var.vm_disk_use_swap
        partitions = var.vm_disk_partitions
        lvm        = var.vm_disk_lvm
      })
      additional_packages = join(" ", var.additional_packages)
    })
  }
  http_ks_command = "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg"
  http_ks_command_with_ip = format(
    "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg ip=%s::%s:%s:hostname:%s:none",
    var.vm_ip_address != null ? var.vm_ip_address : "",
    var.vm_ip_gateway != null ? var.vm_ip_gateway : "",
    var.vm_ip_netmask != null ? var.vm_ip_netmask : "",
    var.vm_network_device
  )
  data_source_command = var.common_data_source == "http" ? (
    var.vm_ip_address != null && var.vm_ip_gateway != null && var.vm_ip_netmask != null ?
    local.http_ks_command_with_ip :
    local.http_ks_command
    ) : (
    var.common_data_source == "disk" ? "inst.ks=cdrom:/ks.cfg" : ""
  )
  vm_name            = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-${local.build_version}"
  bucket_name        = var.hcp_packer_bucket
  bucket_description = "${var.vm_guest_os_family} ${var.vm_guest_os_name} ${var.vm_guest_os_version}"
}
