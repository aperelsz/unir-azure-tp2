# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine


#module "vdisk" {
#  source = "./modules/az_disk"
#  disk_name = "master"
#  rg_location = azurerm_resource_group.rg.location
#  rg_name = azurerm_resource_group.rg.name
#  net_environment = var.environment
#}


module "vnet_master" {
  source = "./modules/az_network"
  net_name = "master"
  rg_location = azurerm_resource_group.rg.location
  rg_name = azurerm_resource_group.rg.name
  net_environment = var.environment
  subnet_id = azurerm_subnet.service_subnet.id
  net_private_ip_address = var.vm_ip_privada_master
}

module "securityRules_master" {
  source = "./modules/az_security"
  security_name = "master"
  permitir_ssh = true
  rg_location = azurerm_resource_group.rg.location
  rg_name = azurerm_resource_group.rg.name
  environment = var.environment
  nic_id = module.vnet_master.nic_id
  rules = {
    ruleA = {
      ruleName = "Http"
      rangePortDest = "28000-35000"
      rangePortSource = "*"
      priority = 500
    }
  }
  #]
}

resource "azurerm_linux_virtual_machine" "vm_master" {
    name                = var.vm_name_master
    computer_name       = var.vm_name_master
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size_master
    admin_username      = var.user_name
    network_interface_ids = [ module.vnet_master.nic_id]
    #network_interface_ids = [ local.nic_id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.user_name
        public_key = file("~/.ssh/id_rsa.pub")
        #public_key = file("./ssh/id_rsa.pub")
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = var.storage_type
    }

    plan {
        name      = var.image_offer
        product   =var.image_offer
        publisher = var.image_publisher
    }

    source_image_reference {
        publisher = var.image_publisher
        offer     = var.image_offer
        sku       = var.image_sku
        version   = var.image_version
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }


    #cloud_init_template = data.template_cloudinit_config.commoninit.rendered

    tags = {
        environment = var.environment
    }

}
