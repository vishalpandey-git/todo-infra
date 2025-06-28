resource "azurerm_mssql_database" "sqldatabase" {
  name         = var.sqldatabase
  server_id    = data.azurerm_mssql_server.sqlserver.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

 
  }
