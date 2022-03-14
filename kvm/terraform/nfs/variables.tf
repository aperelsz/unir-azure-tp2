variable "hostName" {
  type = string
  default = "nfs"
}

variable "interface" {
  type = string
  default = "eth0"
}

variable "memory" {
  type = string
  #default = "2048"
  default = "4096"
}

variable "vcpu" {
  type = number
  default = 2
}

variable "sources" {
  type = string
  default = "/home/libvirt/images/CentOS-8-GenericCloud-8.4.2105-20210603.0.x86_64.qcow2"

}

variable "ip" {
  type = string
  default = "192.168.122.60"
}

variable "mac" {
  type = string
  default = "52:54:00:70:50:b5"
}