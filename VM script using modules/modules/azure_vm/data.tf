
data "azurerm_network_interface" "nic" {
  name                = var.nic
  resource_group_name = var.rg
}

data "azurerm_key_vault" "G31-key-vault" {
  name                = "G31-key-vault"
  resource_group_name = "keyvault-rg"

}

data "azurerm_key_vault_secret" "vishal-username" {
  name = "vishal-username"
  key_vault_id = data.azurerm_key_vault.G31-key-vault.id
  
}

data "azurerm_key_vault_secret" "vishal-pwd" {
  name = "vishal-pwd"
  key_vault_id = data.azurerm_key_vault.G31-key-vault.id
  
}


