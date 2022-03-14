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

variable "workers" {
  type = list(object({
      name = string
      ip = string
      mac = string
    })
  )
  default = [
    {
      name = "Worker01A"
      ip = "192.168.122.111"
      mac = "52:54:00:00:99:c5"
    },
    {
      name = "Worker02A"
      ip = "192.168.122.130"
      mac = "52:54:00:00:ac:c5"
    }
  ]
}