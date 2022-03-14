# Storage account
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
#Mantiene todos los tipos de storage.
#resource "azurerm_storage_account" "stAccount" {
#    name                     = "starage${var.disk_name}" 
#    resource_group_name      = var.rg.name
#    location                 = var.rg.location
#    account_tier             = "Standard"
#    account_replication_type = "LRS" #Tipo de redundancia
#
#    tags = {
#        environment = var.environment
#    }

#}