variable "azurerm_subnet_name" {
  description = "The subnet name."
  default     = "private"
}

variable "azurerm_virtual_network_name" {
  description = "The virtual network name."
  default     = "actions"
}

variable "azurerm_subnet_resource_group_name" {
  description = "The resource group name."
  default     = "actions"
}

variable "image_type" {
  description = "The type of image to test"
  type        = string
  default     = "linux"
}

variable "platform" {
  description = "The target platform to provision the image"
  type        = string
  default     = "azure"
}

variable "hcp_packer_bucket" {
  description = "The name of the bucket to store the packer artifacts"
  type        = string
}

variable "region" {
  description = "The region to deploy the VM"
  type        = string
  default     = "eastus"
}
