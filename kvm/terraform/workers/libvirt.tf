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
  count  = var.hosts
  name   = "disk-${var.hostName}-${count.index}.qcow2"
  pool   = "images"
  source = var.sources
  format = "qcow2"
}


resource "libvirt_cloudinit_disk" "commoninit" { 
  count     = var.hosts
  name      = "commoninit-${var.hostName}-${count.index}.iso"
  pool      = "images"  
  user_data = templatefile("${path.module}/templates/user_data.tpl", {
      host_name = "${var.hostName}${count.index}"
      #auth_key  = file("${path.module}/ssh/id_rsa.pub")
      auth_key  = file("/root/.ssh/id_rsa.pub")
      auth_key_ansible = file("../ssh/id_rsa.pub")
  })
  network_config =   templatefile("${path.module}/templates/network_config.tpl", {
     interface = var.interface
     ip_addr   = var.ips[count.index]
     mac_addr = var.macs[count.index]
  })
}


resource "libvirt_domain" "domain-distro" {
  
  count  = var.hosts
  name   = "${var.hostName}-${count.index}"
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = element(libvirt_cloudinit_disk.commoninit.*.id, count.index)
  
  network_interface {
    network_name = "default"
    addresses    = [var.ips[count.index]]
    mac          = var.macs[count.index]
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