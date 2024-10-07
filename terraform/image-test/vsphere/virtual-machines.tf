data "vsphere_datacenter" "datacenter" {
  count = var.platform == "vsphere" ? 1 : 0
  name  = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  count         = var.platform == "vsphere" ? 1 : 0
  name          = var.vsphere_datastore
  datacenter_id = one(data.vsphere_datacenter.datacenter.*.id)
}

data "vsphere_host" "host" {
  count         = var.platform == "vsphere" ? 1 : 0
  name          = var.vsphere_host
  datacenter_id = one(data.vsphere_datacenter.datacenter.*.id)
}

data "vsphere_compute_cluster" "cluster" {
  count         = var.platform == "vsphere" ? 1 : 0
  name          = var.vsphere_cluster
  datacenter_id = one(data.vsphere_datacenter.datacenter.*.id)
}

data "vsphere_network" "network" {
  count         = var.platform == "vsphere" ? 1 : 0
  name          = var.vsphere_network
  datacenter_id = one(data.vsphere_datacenter.datacenter.*.id)
}

data "vsphere_virtual_machine" "template" {
  count         = var.platform == "vsphere" ? 1 : 0
  name          = data.hcp_packer_artifact.this.external_identifier
  datacenter_id = one(data.vsphere_datacenter.datacenter.*.id)
}

resource "vsphere_virtual_machine" "linux" {
  count            = var.image_type != "windows" && var.platform == "vsphere" ? 1 : 0
  name             = "${var.hcp_packer_bucket}-test"
  resource_pool_id = one(data.vsphere_host.host.*.resource_pool_id)
  datastore_id     = one(data.vsphere_datastore.datastore.*.id)
  num_cpus         = 2
  memory           = 2048
  guest_id         = one(data.vsphere_virtual_machine.template.*.guest_id)
  firmware         = one(data.vsphere_virtual_machine.template.*.firmware)
  network_interface {
    network_id   = one(data.vsphere_network.network.*.id)
    adapter_type = one(data.vsphere_virtual_machine.template.*.network_interface_types[0])
  }
  disk {
    label = "disk0"
    size  = one(data.vsphere_virtual_machine.template.*.disks.0.size)
  }
  clone {
    template_uuid = one(data.vsphere_virtual_machine.template.*.id)
    customize {
      linux_options {
        host_name = "${var.hcp_packer_bucket}-test"
        domain    = "danquack.dev"
      }
      network_interface {
      }
    }
  }
}

resource "vsphere_virtual_machine" "windows" {
  count            = var.image_type == "windows" && var.platform == "vsphere" ? 1 : 0
  name             = "${var.hcp_packer_bucket}-test"
  resource_pool_id = one(data.vsphere_host.host.*.resource_pool_id)
  datastore_id     = one(data.vsphere_datastore.datastore.*.id)
  num_cpus         = 2
  memory           = 2048
  guest_id         = one(data.vsphere_virtual_machine.template.*.guest_id)
  firmware         = one(data.vsphere_virtual_machine.template.*.firmware)
  network_interface {
    network_id   = one(data.vsphere_network.network.*.id)
    adapter_type = one(data.vsphere_virtual_machine.template.*.network_interface_types[0])
  }
  disk {
    label = "disk0"
    size  = one(data.vsphere_virtual_machine.template.*.disks.0.size)
  }
  clone {
    template_uuid = one(data.vsphere_virtual_machine.template.*.id)
    customize {
      windows_options {
        computer_name = "${var.hcp_packer_bucket}-test"
        workgroup     = "danquack"
      }
      network_interface {
      }
    }
  }
}
