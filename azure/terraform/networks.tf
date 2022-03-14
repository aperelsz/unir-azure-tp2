# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "service_net" {
    name                = "${var.service_name}_net"
    address_space       = [var.net_address_space]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = var.environment
    }
}

# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "service_subnet" {
    name                   = "${var.service_name}_subnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.service_net.name
    address_prefixes       = [var.net_address_prefixes]
}