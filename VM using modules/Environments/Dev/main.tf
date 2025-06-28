module "azure_rg" {
  source   = "../../modules/azure_rg"
  rg       = "vishalrg"
  location = "east us"

}

module "azure_vnet" {
  depends_on    = [module.azure_rg]
  source        = "../../modules/azure_vnet"
  rg            = "vishalrg"
  location      = "east us"
  vnet          = "vnetdev"
  address_space = ["10.0.0.0/16"]

}

module "azure_subnet_frontend" {
  depends_on       = [module.azure_vnet]
  source           = "../../modules/azure_subnet"
  rg               = "vishalrg"
  vnet             = "vnetdev"
  subnet           = "devsubnet_frontend"
  address_prefixes = ["10.0.1.0/24"]
}

module "azure_subnet_backend" {
  depends_on       = [module.azure_vnet]
  source           = "../../modules/azure_subnet"
  rg               = "vishalrg"
  vnet             = "vnetdev"
  subnet           = "devsubnet_backend"
  address_prefixes = ["10.0.1.0/24"]
}

module "azure_nic_frontend" {
  depends_on = [module.azure_subnet_frontend]
  source     = "../../modules/azure_nic"
  rg         = "vishalrg"
  location   = "east us"
  nic        = "devnic_frontend"
  vnet       = "vnetdev"
  subnet     = "devsubnet_frontend"
  pip        = "devpip_frontend"

}

module "azure_nic_backend" {
  depends_on = [module.azure_subnet_backend]
  source     = "../../modules/azure_nic"
  rg         = "vishalrg"
  location   = "east us"
  nic        = "devnic"
  vnet       = "vnetdev"
  subnet     = "devsubnet_backend"
  pip        = "devpip_backend"

}
module "azure_pip_frontend" {
  depends_on        = [module.azure_rg]
  source            = "../../modules/azure_pip"
  rg                = "vishalrg"
  allocation_method = "Static"
  pip               = "devpip_frontend"
  location          = "east us"
}

module "azure_pip_backend" {
  depends_on        = [module.azure_rg]
  source            = "../../modules/azure_pip"
  rg                = "vishalrg"
  allocation_method = "Static"
  pip               = "devpip_backend"
  location          = "east us"
}

module "azure_vm_frontend" {
  depends_on = [module.azure_nic_frontend]
  source     = "../../modules/azure_vm"
  vm         = "vmdev_frontend"
  rg         = "vishalrg"
  location   = "east us"
  size       = "Standard_ds_v6"
  publisher  = "Canonical"
  offer      = "0001-com-ubuntu-server-jammy"
  sku        = "22_04-lts"
  nic        = "devnic"
  key_vault  = "vishal_key_vault"

}

module "azure_vm_backend" {
  depends_on = [module.azure_nic_backend]
  source     = "../../modules/azure_vm"
  vm         = "vmdev_backend"
  rg         = "vishalrg"
  location   = "east us"
  size       = "Standard_ds_v6"
  publisher  = "Canonical"
  offer      = "0001-com-ubuntu-server-jammy"
  sku        = "20_04-lts"
  nic        = "devnic"
  key_vault  = "vishal_key_vault"

}

module "azure_mssql_sever" {
  depends_on = [module.azure_rg]
  source     = "../../modules/azure_mssql_server"
  sqlserver  = "vishalsql239"
  rg         = "vishalrg"
  location   = "Central US"

}

module "azure_mssql_database" {
  depends_on  = [module.azure_mssql_sever]
  source      = "../../modules/azure_mssql_database"
  sqldatabase = "vishaldatabase23"
  sqlserver   = "vishalsql239"
  rg          = "vishalrg"
}

module "azure_nsg_backend" {
  depends_on = [module.azure_nic_backend, module.azure_rg]

  source   = "../../modules/Azure_nsg"
  nsg      = "devnsg_backend"
  location = "east us"
  rg       = "vishalrg"
  nic      = "devnic_backend"

}

module "azure_nsg_frontend" {
  depends_on = [module.azure_nic_frontend, module.azure_rg]

  source   = "../../modules/Azure_nsg"
  nsg      = "devnsg_frontend"
  location = "east us"
  rg       = "vishalrg"
  nic      = "devnic_frontend"

}


# module "azurerm_key_vault" {
#   depends_on = [module.azure_rg, module.azure_vm]
#   source     = "../../modules/azure_key_vault"
#   rg         = "vishalrg"
#   location   = "east us"
#   key_vault  = "vishal_key_vault"


# }
