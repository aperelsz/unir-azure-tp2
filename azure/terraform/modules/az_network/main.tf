# Create NIC
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "service_nic" {
  name                = "${var.net_prefix_name}_nic_${var.net_name}"  
  location            = var.rg_location
  resource_group_name = var.rg_name

    ip_configuration {
      name                           = "${var.net_prefix_name}_ipconf_${var.net_name}"
      subnet_id                      = var.subnet_id 
      private_ip_address_allocation  = "Static"
      private_ip_address             = var.net_private_ip_address
      public_ip_address_id           = azurerm_public_ip.service_publicIp.id
    }

    tags = {
        environment = var.net_environment
    }
}

# IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "service_publicIp" {
  name                = "${var.net_prefix_name}_publicip_${var.net_name}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags = {
    environment = var.net_environment
  }
}