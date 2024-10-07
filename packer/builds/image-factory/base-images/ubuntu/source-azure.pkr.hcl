source "azure-arm" "ubuntu" {

  image_offer                         = "ubuntu-24_04-lts"
  image_publisher                     = "canonical"
  image_sku                           = "server"
  location                            = "eastus"
  managed_image_name                  = "ubuntu-base"
  managed_image_resource_group_name   = "packer"
  os_type                             = "Linux"
  virtual_network_name                = "actions"
  virtual_network_resource_group_name = "actions"
  virtual_network_subnet_name         = "private"

  vm_size         = "Standard_DS2_v2"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
}