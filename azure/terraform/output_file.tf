 resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/ansible_inventory.tmpl",
    {
     ansible_master_ip =  azurerm_linux_virtual_machine.vm_master.public_ip_address,
     ansible_nfs_ip =  azurerm_linux_virtual_machine.vm_nfs.public_ip_address,
     ansible_workers_ip = azurerm_linux_virtual_machine.vm_workes.*.public_ip_address,
    }
  )
  filename = "../ansible/hosts"
}


resource "local_file" "ansible_nfs_ip" {
  content = templatefile("./templates/ansible_nfs_ip.tmpl",
    {
     ansible_nfs_ip =  azurerm_linux_virtual_machine.vm_nfs.public_ip_address,
    }
  )
  filename = "../ansible/group_vars/kube_ip_nfs.yaml"
}


resource "local_file" "resumen_despliegue" {
  content = templatefile("./templates/resumen_despliegue.tmpl",
    {
      master_ip = azurerm_linux_virtual_machine.vm_master.public_ip_address,
      nfs_ip =  azurerm_linux_virtual_machine.vm_nfs.public_ip_address,
      workers_ip = azurerm_linux_virtual_machine.vm_workes.*.public_ip_address,
    }
  )
  filename = "../resumen.out"
}
