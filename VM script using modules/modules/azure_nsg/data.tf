data "azurerm_network_interface" "nic" {
  name                = var.nic
  resource_group_name = var.rg
}