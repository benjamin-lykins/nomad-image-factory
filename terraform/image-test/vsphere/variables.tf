variable "image_type" {
  description = "The type of image to test"
  type        = string
  default     = "linux"
}

variable "platform" {
  description = "The target platform to provision the image"
  type        = string
  default     = "vsphere"
}

variable "hcp_packer_bucket" {
  description = "The name of the bucket to store the packer artifacts"
  type        = string
}

variable "vsphere_datacenter" {
  description = "The name of the datacenter to deploy the VM"
  type        = string
  default     = "Datacenter"
}

variable "vsphere_cluster" {
  description = "The name of the cluster to deploy the VM"
  type        = string
  default     = "Cluster"
}

variable "vsphere_network" {
  description = "The name of the network to deploy the VM"
  type        = string
  default     = "VM"
}

variable "vsphere_datastore" {
  description = "The name of the datastore to deploy the VM"
  type        = string
  default     = "terramaster-0"
}

variable "vsphere_host" {
  description = "The name of the host to deploy the VM"
  type        = string
  default     = "192.168.8.4"
}

variable "region" {
  description = "The region to deploy the VM"
  type        = string
  default     = "Datacenter"
}
