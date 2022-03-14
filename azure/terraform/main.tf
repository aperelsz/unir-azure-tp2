
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
    name = var.resource_name
    location = var.location
    tags = {
        environment = var.environment
    }

}

# Storage account
#Mantiene todos los tipos de storage.
resource "azurerm_storage_account" "stAccount" {
    name                     = "starage${var.storage_name}" 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS" #Tipo de redundancia

    tags = {
        environment = var.environment
    }

}

