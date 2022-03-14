variable "vm_size_workers" {
  type = string
  description = "Tamaño de la máquina virtual"
  #default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
  default = "Standard_A2_v2" # 3.5 GB, 1 CPU 
}

variable "workers" {
  type = list(object({
      name = string
      privateIp = string
    })
  )
  default = [
    {
      name = "Worker01"
      privateIp = "10.0.1.50"
#    },
#    {
#      name = "Worker02"
#      privateIp = "10.0.1.55"
    }
  ]
}