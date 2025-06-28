data "azurerm_mssql_server" "sqlserver" {
  name                = var.sqlserver
  resource_group_name = var.rg
}