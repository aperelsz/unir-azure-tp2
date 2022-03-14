terraform {
  #required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      # version = "0.6.3"
    }
  }
}
provider "libvirt" {
  uri = "qemu:///system"
}


resource "libvirt_volume" "volumen-qcow2" {
  count  = length(var.workers)
  name   = "disk-${var.workers[count.index].name}.qcow2"
  pool   = "images"
  source = var.sources
  format = "qcow2"
}


resource "libvirt_cloudinit_disk" "commoninit" { 
  count = length(var.workers)
  name = "commoninit-${var.workers[count.index].name}.iso"
  pool = "images"  
  user_data = templatefile("${path.module}/templates/user_data.tpl", {
      host_name = "${var.workers[count.index].name}"
      #auth_key  = file("${path.module}/ssh/id_rsa.pub")
      auth_key  = file("/root/.ssh/id_rsa.pub")
      auth_key_ansible = file("../ssh/id_rsa.pub")
  })
  network_config =   templatefile("${path.module}/templates/network_config.tpl", {
     interface = var.interface
     ip_addr   = "${var.workers[count.index].ip}"
     mac_addr = "${var.workers[count.index].mac}"
  })
}


resource "libvirt_domain" "domain-distro" {
  count = length(var.workers) 
  #for_each = var.workers
  #name = "${each.value.name}"
  name = "${var.workers[count.index].name}"
  
  #name   = "${var.hostName}-${count.index}"
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = element(libvirt_cloudinit_disk.commoninit.*.id, count.index )
  
  network_interface {
    network_name = "default"
    addresses    = ["${var.workers[count.index].ip}"]
    mac          = "${var.workers[count.index].mac}"
  }
  
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
  
  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }
  
  disk {
    volume_id = element(libvirt_volume.volumen-qcow2.*.id, count.index)
  }

}