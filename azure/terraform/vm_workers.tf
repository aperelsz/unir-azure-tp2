# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine


# Llama al modulo de creacion Nic, permite crear una ip publica dinamica y ip privada.
# Se deden enviar como parametros las variables definidad en ./modules/az_network/vars.tf 
# (Si poseen default, se puden obviar ya que tomara esta)
module "vnet_workes" {
  count = length(var.workers)
  source = "./modules/az_network"
  net_name = "${var.workers[count.index].name}"
  rg_location = azurerm_resource_group.rg.location
  rg_name = azurerm_resource_group.rg.name
  net_environment = var.environment
  subnet_id = azurerm_subnet.service_subnet.id
  net_private_ip_address = "${var.workers[count.index].privateIp}" #Ip privada de vm
}


module "securityRules_workers" {
  count = length(var.workers)
  source = "./modules/az_security"
  security_name = "${var.workers[count.index].name}"
  permitir_ssh = true
  rg_location = azurerm_resource_group.rg.location
  rg_name = azurerm_resource_group.rg.name
  environment = var.environment
  nic_id = element(module.vnet_workes.*.nic_id,count.index)
  rules = {}
}

resource "azurerm_linux_virtual_machine" "vm_workes" {
    count               = length(var.workers)
    name                = "${var.workers[count.index].name}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size_workers
    admin_username      = var.user_name
    network_interface_ids = [ element(module.vnet_workes.*.nic_id,count.index)]
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