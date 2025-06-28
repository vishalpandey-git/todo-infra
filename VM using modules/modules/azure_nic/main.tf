resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip.id
  }
}
