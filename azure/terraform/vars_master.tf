variable "vm_name_master" {
  type = string
  description = "Nombre maquina virtual"
  default = "master" 
}

variable "vm_size_master" {
  type = string
  description = "Tamaño de la máquina virtual"
  #default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
  #default = "Standard_A2_v2" # 3.5 GB, 1 CPU 
  default = "Standard_D2_v3" # 3.5 GB, 1 CPU 
}


variable "vm_ip_privada_master" {
  type = string
  description = "Ip privada"
  default = "10.0.1.30"
}

