resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm
  resource_group_name = var.rg
  location            = var.location
  size                = var.size
  admin_username      = data.azurerm_key_vault_secret.vishal-username.value
  admin_password      = data.azurerm_key_vault_secret.vishal-pwd.value
  network_interface_ids = [
    data.azurerm_network_interface.nic.id
  ]
  disable_password_authentication = "false"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
  custom_data = base64encode(<<-EOF
  #!/bin/bash
  apt-get update
  apt-get install -y nginx
  systemctl enable nginx
  systemctl start nginx
EOF
)
}
