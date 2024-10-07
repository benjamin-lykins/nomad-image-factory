data "hcp-packer-artifact" "azure-docker" {
  bucket_name   = "azure-docker"
  channel_name  = "latest"
  platform      = "azure"
  region        = "eastus"
}

source "azure-arm" "nomad-client" {
  custom_managed_image_name                = "docker"
  custom_managed_image_resource_group_name = "packer"
  location                                 = "eastus"
  managed_image_name                       = "nomad-client"
  managed_image_resource_group_name        = "packer"
  os_type                                  = "Linux"
  virtual_network_name                     = "actions"
  virtual_network_resource_group_name      = "actions"
  virtual_network_subnet_name              = "private"

  vm_size         = "Standard_DS2_v2"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
}

source "azure-arm" "nomad-server" {
  custom_managed_image_name                = "docker"
  custom_managed_image_resource_group_name = "packer"
  location                                 = "eastus"
  managed_image_name                       = "nomad-server"
  managed_image_resource_group_name        = "packer"
  os_type                                  = "Linux"
  virtual_network_name                     = "actions"
  virtual_network_resource_group_name      = "actions"
  virtual_network_subnet_name              = "private"

  vm_size         = "Standard_DS2_v2"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
}

source "azure-arm" "nomad-shared" {
  custom_managed_image_name                = "docker"
  custom_managed_image_resource_group_name = "packer"
  location                                 = "eastus"
  managed_image_name                       = "nomad-shared"
  managed_image_resource_group_name        = "packer"
  os_type                                  = "Linux"
  virtual_network_name                     = "actions"
  virtual_network_resource_group_name      = "actions"
  virtual_network_subnet_name              = "private"

  vm_size         = "Standard_DS2_v2"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
}