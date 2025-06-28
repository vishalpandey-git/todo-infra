resource "azurerm_public_ip" "pip" {
  name                = var.pip
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = var.allocation_method
}