resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlserver
  resource_group_name          = var.rg
  location                     = var.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.vishal-username.value
  administrator_login_password = data.azurerm_key_vault_secret.vishal-pwd.value
  minimum_tls_version          = "1.2"


  }
