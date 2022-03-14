variable "hosts" {
  type = number
  default = 1
}

variable "hostName" {
  type = string
  default = "worker"
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

variable "ips" {
  type = list
  default = ["192.168.122.11", "192.168.122.22", "192.168.122.33"]
}

variable "macs" {
  type = list
  default = ["52:54:00:50:99:c5", "52:54:00:0e:87:be", "52:54:00:9d:90:38"]
}