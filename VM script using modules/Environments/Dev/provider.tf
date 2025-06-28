terraform {
  required_version = "1.11.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "f0cb494b-a275-45f4-895c-33af48053122"
}
