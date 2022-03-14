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
  name   = "disk-${var.hostName}.qcow2"
  pool   = "images"
  source = var.sources
  format = "qcow2"
}


resource "libvirt_cloudinit_disk" "commoninit" { 
  name      = "commoninit-${var.hostName}.iso"
  pool      = "images"  
  user_data = templatefile("${path.module}/templates/user_data.tpl", {
      host_name = var.hostName
      #auth_key  = file("${path.module}/ssh/id_rsa.pub")
      auth_key  = file("/root/.ssh/id_rsa.pub")
      auth_key_ansible = file("../ssh/id_rsa.pub")
  })
  network_config = templatefile("${path.module}/templates/network_config.tpl", {
     interface = var.interface
     ip_addr   = var.ip
     mac_addr = var.mac
  })
}


resource "libvirt_domain" "domain-distro" {
 
  name   = "${var.hostName}"
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit.id
  
  network_interface {
    network_name = "default"
    addresses    = [var.ip]
    mac          = var.mac
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
    volume_id = libvirt_volume.volumen-qcow2.id
  }

}