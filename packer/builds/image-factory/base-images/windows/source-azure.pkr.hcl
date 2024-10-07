source "azure-arm" "windows-full" {
  image_offer                         = "WindowsServer"
  image_publisher                     = "MicrosoftWindowsServer"
  image_sku                           = "2022-datacenter"
  location                            = "eastus"
  managed_image_name                  = "windows-full-base"
  managed_image_resource_group_name   = "packer"
  os_type                             = "Windows"
  virtual_network_name                = "actions"
  virtual_network_resource_group_name = "actions"
  virtual_network_subnet_name         = "private"

  vm_size         = "Standard_DS2_v2"
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id

  communicator   = "winrm"
  winrm_insecure = true
  winrm_timeout  = "7m"
  winrm_use_ssl  = true
  winrm_username = "hashiconf2024"

}