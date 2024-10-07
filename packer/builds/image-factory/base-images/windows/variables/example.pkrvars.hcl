# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Microsoft Windows Server 2025 build variables.
    Packer Plugin for VMware vSphere: 'vsphere-iso' builder.
*/

// vSphere Credentials
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter                     = "Datacenter"
// vsphere_cluster                        = "Cluster"
vsphere_host                         = "192.168.8.4"
vsphere_datastore                      = "terramaster-0"
vsphere_network                        = "VM"
vsphere_folder                         = "packer/base"
//vsphere_resource_pool                = "sfo-w01-rp01"
vsphere_set_host_for_datastore_uploads = false

// Installation Operating System Metadata
vm_inst_os_key_standard             = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
vm_inst_os_key_datacenter           = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "windows2019srvNext_64Guest"

// Note:
// You can set `windows2022srvNext_64Guest` if `common_vm_version` for the virtual hardware is `20` or later. Requires vSphere 8.0.

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"

// Removable Media Settings
common_iso_datastore               = "terramaster-0"
iso_datastore_path                 = "iso/windows/"
iso_file                           = "windows-server-22.iso"


// Ansible Credentials
ansible_username = "ansible"
ansible_key      = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHqWj5PfbkbGqiyhA2aJIpoWawhpu0AA/hn3xfvPD3cnhImhvp7lY72NfFJZYOcrv/iZQTAnjsprvn4ImvjjoXXNQEgiqmI0z9jZSNfcBEg7dyRATdt4hdsUuFx5ZfSXt2whE9TBNmysIih4y0YuBJWWXu0ImIzs+R27IMwFSbJzL8RVg== ansible@example.com"

// Default Account Credentials
build_username           = "hashiconf2024"
build_password           = "hashiconf2024"
build_password_encrypted = "$6$i2ciZjwl$rY8yTyj0JgMpvzhZ2Q7rij.d.wAVzu1M4cPUE3kElXSjOKtmH5vCN24GmXrkuSGkc39SmV/jWcG6SPwZ97tmN."
build_key                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLfywq7QhCgAC9UWTYR4uisU687Gg5k1ZsBMfzMOIYmwi0G6kvlPa0Xj/ZtooZ7Go7BGgEF6hQfa6WRbmKRmxvFUbIYhpVyaDQsrVTawcLJsfjlfJUnrSOvOfHzgo3Kmm1fWESzYn7AX5FI6FXzyRDbpv2Ul9jg8y8F6kxq+V6LqYlkk/NUBk35Zseo03R+8TF/oN1QFJpOqLGGVotahWeoudw7A1acSmAeSFcfGNbG2Be94FY9h7U7lZBscsURvDphO2t3EtQU58FBND/ypXaWPM6h5AXP0d5/Zm2ru6t5cgoSzmL4Q1LTyQ2Y/wpFIDNqUYhvjsasG4nnLViSRxDKRLrWYYWruL1RRpgWp97t9CzEUugbCCdlR3s6aJn21qbmUOXmL/IaaICSkNPYsMkd+RBOVuGMHnZIxWTSEC+MqqnVMpwApNI68AF5TU3M6806eqQC5P4HwH652vNgnvvkM7lE+K4XO5fVmyUYJCLyB7sBz3H+JZFOmKPg3ls3k8= lykins@Benjamins-MacBook-Pro.local"

// Virtual Machine Settings
common_vm_version           = 20
common_tools_upgrade_policy = true
common_remove_cdrom         = true

// Template and Content Library Settings
common_template_conversion         = true




// Boot and Provisioning Settings
common_data_source       = "http"
common_ip_wait_timeout   = "20m"
common_ip_settle_timeout = "5s"
common_shutdown_timeout  = "15m"

// HCP Packer
common_hcp_packer_registry_enabled = true
