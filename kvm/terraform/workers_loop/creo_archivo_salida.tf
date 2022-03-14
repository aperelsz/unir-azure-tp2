 resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/ansible_inventory.tmpl",
    {
     ansible_master_ip =  libvirt_domain.domain-distro[0].name,
     ansible_nfs_ip =  libvirt_domain.domain-distro[1].name,
     ansible_workers_ip = libvirt_domain.domain-distro.*.name,
    }
  )
  filename = "../../ansible/hostsa"
}


resource "local_file" "ansible_nfs_ip" {
  content = templatefile("./templates/ansible_nfs_ip.tmpl",
    {
     ansible_nfs_ip =  libvirt_domain.domain-distro[1].name,
    }
  )
  filename = "../../ansible/group_vars/kube_ip_nfs.yaml"
}
