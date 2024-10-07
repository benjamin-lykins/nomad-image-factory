# Copyright 2023-2024 Broadcom. All rights reserved.
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    Ubuntu Server 24.04 LTS build variables.
    Packer Plugin for VMware vSphere: 'vsphere-iso' builder.
*/


// vSphere Credentials
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter                     = "Datacenter"
// vsphere_cluster                        = "Cluster"
vsphere_host                         =   "192.168.8.4"
vsphere_datastore                      = "terramaster-0"
vsphere_network                        = "VM"
vsphere_folder                         = "packer/base"
//vsphere_resource_pool                = "sfo-w01-rp01"
vsphere_set_host_for_datastore_uploads = false


// Guest Operating System Metadata
vm_guest_os_name     = "ubuntu"
vm_guest_os_version  = "24.04"
vm_guest_os_cloudinit = false


// Virtual Machine Guest Operating System Setting
vm_guest_os_type      = "ubuntu64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi-secure"

// Removable Media Settings
iso_datastore_path       = "iso/linux/ubuntu"

iso_file                 = "ubuntu-server-24.iso"


// Ansible Credentials
ansible_username = "ansible"
ansible_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC206CqNT6t+XOIwksENcWPlxjXIAosCftVEyQQkHEvdetvxhRnds1lybnWgiSQTcz7VWlnjnEQlPWc4S16fzEFR6yCFnftGfdmbkgOL0FaNfsYQ4UXEAms8O2noMIpoGaoZD/y0myry7DUlKM/mBAkuTL/mvE8UtRoZHPQ8dIUGHx9ekvS7YwfEkK8i2xp/3SZ4Eho+mbTQcLovymrllBmr6AZvG3ZunBVsXuD2xcNz8KJru0Oaa0EjTFRmoTEhfw2Adw0KwE5Pk9ds4Sj0hVcCY3QBiRJVCgwzT3YDJ+e++DUWkmY9uF+v/hsSTRfmx6i5LR8NFz9HTDXTkc9gOdpOYUhSIvxwbl3ETwlTYsH3ZsQfnBDQs6RdN9ZgXHR/aMdfgBmeBn8RuNxZNSQKACVxsebp/x1Ndlpj2yMRVROvoHy4L36ZfxvchH3rRBM8Nm/KJD4ySByDnB3T/JUv8SGLNVHdrkwaFHh7e5xjZac3fKldw9VsULAT7Woj05wASkwNIMxeg0OvANgYJzSZ71Rs9VaBD2eBO85A1pnXHN1sJ98BpMqXIISKmhGyfFDZcK7sxKxlCrxJ/wbWGTXgWTtUVUMwlqBXFdbKNitEIxXvImCx0daSJWONfmlgrKESq31YOC6uVxl/cKoUD+y/HZCW7TERsUuCI54K1Z3IU2NTw== ansible@danquack.dev"

// Default Account Credentials
build_username           = "hashiconf2024"
build_password           = "hashiconf2024"
build_password_encrypted = "$6$i2ciZjwl$rY8yTyj0JgMpvzhZ2Q7rij.d.wAVzu1M4cPUE3kElXSjOKtmH5vCN24GmXrkuSGkc39SmV/jWcG6SPwZ97tmN."
build_key                = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLfywq7QhCgAC9UWTYR4uisU687Gg5k1ZsBMfzMOIYmwi0G6kvlPa0Xj/ZtooZ7Go7BGgEF6hQfa6WRbmKRmxvFUbIYhpVyaDQsrVTawcLJsfjlfJUnrSOvOfHzgo3Kmm1fWESzYn7AX5FI6FXzyRDbpv2Ul9jg8y8F6kxq+V6LqYlkk/NUBk35Zseo03R+8TF/oN1QFJpOqLGGVotahWeoudw7A1acSmAeSFcfGNbG2Be94FY9h7U7lZBscsURvDphO2t3EtQU58FBND/ypXaWPM6h5AXP0d5/Zm2ru6t5cgoSzmL4Q1LTyQ2Y/wpFIDNqUYhvjsasG4nnLViSRxDKRLrWYYWruL1RRpgWp97t9CzEUugbCCdlR3s6aJn21qbmUOXmL/IaaICSkNPYsMkd+RBOVuGMHnZIxWTSEC+MqqnVMpwApNI68AF5TU3M6806eqQC5P4HwH652vNgnvvkM7lE+K4XO5fVmyUYJCLyB7sBz3H+JZFOmKPg3ls3k8= lykins@Benjamins-MacBook-Pro.local"


// Virtual Machine Settings
common_vm_version           = 19
common_tools_upgrade_policy = true
common_remove_cdrom         = true

// Template and Content Library Settings
common_template_conversion         = true




// Removable Media Settings
common_iso_datastore               = "terramaster-0"


// Boot and Provisioning Settings
common_data_source       = "http"
common_ip_wait_timeout   = "20m"
common_ip_settle_timeout = "5s"
common_shutdown_timeout  = "15m"

// HCP Packer
common_hcp_packer_registry_enabled = true

// Packages
additional_packages = [
  "util-linux-extra",
  "cloud-initramfs-growroot",
  "wget", 
  "net-tools",
  "unzip",
  "ca-certificates",
  "apparmor"
]


# Disk
vm_disk_device   = "sda"
vm_disk_use_swap = true
vm_disk_partitions = [
  {
    name = "efi"
    size = 1024,
    format = {
      label  = "EFIFS",
      fstype = "fat32",
    },
    mount = {
      path    = "/boot/efi",
      options = "",
    },
    volume_group = "",
  },
  {
    name = "boot"
    size = 1024,
    format = {
      label  = "BOOTFS",
      fstype = "xfs",
    },
    mount = {
      path    = "/boot",
      options = "",
    },
    volume_group = "",
  },
  {
    name = "sysvg"
    size = -1,
    format = {
      label  = "",
      fstype = "",
    },
    mount = {
      path    = "",
      options = "",
    },
    volume_group = "sysvg",
  },
]
vm_disk_lvm = [
  {
    name : "sysvg",
    partitions : [
      {
        name = "lv_swap",
        size = 1024,
        format = {
          label  = "SWAPFS",
          fstype = "swap",
        },
        mount = {
          path    = "",
          options = "",
        },
      },
      {
        name = "lv_root",
        size = 15360,
        format = {
          label  = "ROOTFS",
          fstype = "xfs",
        },
        mount = {
          path    = "/",
          options = "",
        },
      },
      {
        name = "lv_home",
        size = 4096,
        format = {
          label  = "HOMEFS",
          fstype = "xfs",
        },
        mount = {
          path    = "/home",
          options = "nodev,nosuid",
        },
      },
      {
        name = "lv_opt",
        size = 2048,
        format = {
          label  = "OPTFS",
          fstype = "xfs",
        },
        mount = {
          path    = "/opt",
          options = "nodev",
        },
      },
      {
        name = "lv_tmp",
        size = 4096,
        format = {
          label  = "TMPFS",
          fstype = "xfs",
        },
        mount = {
          path    = "/tmp",
          options = "nodev,noexec,nosuid",
        },
      },
      {
        name = "lv_var",
        size = 4096,
        format = {
          label  = "VARFS",
          fstype = "xfs",
        },
        mount = {
          path    = "/var",
          options = "nodev",
        },
      },
      {
        name = "lv_log",
        size = 4096,
        format = {
          label  = "LOGFS",
          fstype = "xfs",
        },
        mount = {
          path    = "/var/log",
          options = "nodev,noexec,nosuid",
        },
      },
      {
        name = "lv_audit",
        size = -1,
        format = {
          label  = "AUDITFS",
          fstype = "xfs",
        },
        mount = {
          path    = "/var/log/audit",
          options = "nodev,noexec,nosuid",
        },
      },
    ],
  }
]
