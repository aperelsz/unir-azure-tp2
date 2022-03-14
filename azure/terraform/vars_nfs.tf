variable "vm_name_nfs" {
  type = string
  description = "Nombre maquina virtual"
  default = "nfs" 
}

variable "vm_size_nfs" {
  type = string
  description = "Tamaño de la máquina virtual"
  #default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
  default = "Standard_A2_v2" # 3.5 GB, 1 CPU 
}

variable "vm_ip_privada_nfs" {
  type = string
  description = "Ip privada"
  default = "10.0.1.20"
}