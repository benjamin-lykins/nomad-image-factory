resource "azurerm_resource_group" "this" {
  count    = var.platform == "azure" ? 1 : 0
  name     = "${var.hcp_packer_bucket}-test"
  location = "eastus"
}

data "azurerm_subnet" "this" {
  count                = var.platform == "azure" ? 1 : 0
  name                 = var.azurerm_subnet_name
  virtual_network_name = var.azurerm_virtual_network_name
  resource_group_name  = var.azurerm_subnet_resource_group_name
}

resource "azurerm_network_interface" "this" {
  count               = var.platform == "azure" ? 1 : 0
  name                = "${var.hcp_packer_bucket}-test-nic"
  location            = one(azurerm_resource_group.this.*.location)
  resource_group_name = one(azurerm_resource_group.this.*.name)

  ip_configuration {
    name                          = "internal"
    subnet_id                     = one(data.azurerm_subnet.this.*.id)
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windows" {
  count               = var.platform == "azure" && var.image_type == "windows" ? 1 : 0
  name                = "${var.hcp_packer_bucket}-test"
  source_image_id     = data.hcp_packer_artifact.this.external_identifier
  resource_group_name = one(azurerm_resource_group.this.*.name)
  location            = one(azurerm_resource_group.this.*.location)
  size                = "Standard_DS2_v2"
  admin_username      = "hashiconf2024"
  admin_password      = "Hashiconf2024!"
  network_interface_ids = [
    one(azurerm_network_interface.this.*.id),
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource "azurerm_linux_virtual_machine" "linux" {
  count                           = var.platform == "azure" && var.image_type != "windows" ? 1 : 0
  name                            = "${var.hcp_packer_bucket}-test"
  computer_name                   = "hashiconf2024"
  source_image_id                 = data.hcp_packer_artifact.this.external_identifier
  resource_group_name             = one(azurerm_resource_group.this.*.name)
  location                        = one(azurerm_resource_group.this.*.location)
  size                            = "Standard_DS2_v2"
  admin_username                  = "hashiconf2024"
  admin_password                  = "Hashiconf2024!"
  disable_password_authentication = false
  network_interface_ids = [
    one(azurerm_network_interface.this.*.id),
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

