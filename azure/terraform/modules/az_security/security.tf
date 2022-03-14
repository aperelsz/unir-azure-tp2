resource "azurerm_network_security_rule" "example" {
  for_each = var.rules
  name                        = "${each.value.ruleName}_${var.security_name}"
  priority                    = "${each.value.priority}"
  direction                   = "Inbound"  
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "${each.value.rangePortSource}"
  destination_port_range      = "${each.value.rangePortDest}"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.service_secGroup.name
}

resource "azurerm_network_security_rule" "ssh" {
  count = var.permitir_ssh ? 1 : 0
  name                        = "sshsecurity_${var.security_name}"
  priority                    = 1001
  direction                   = "Inbound"  
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.service_secGroup.name
}

# Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "service_secGroup" {
    name                = "rules_traffic_${var.security_name}"
    location            = var.rg_location
    resource_group_name = var.rg_name

    #security_rule {
    #    name                       = "${var.ruleName}"
    #    priority                   = 1001
    #    direction                  = "Inbound"
    #    access                     = "Allow"
    #    protocol                   = "Tcp"
    #    source_port_range          = "${var.rangePortSource}"
    #    destination_port_range     = "${var.rangePortDest}"
    #    source_address_prefix      = "*"
    #    destination_address_prefix = "*"
    #}

    tags = {
        environment = var.environment
    }
}

# Vinculamos el security group al interface de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "service_secGroupAssociation" {
    network_interface_id = var.nic_id
    network_security_group_id = azurerm_network_security_group.service_secGroup.id

}