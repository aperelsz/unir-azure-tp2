variable "resource_name" {
  type = string
  description = "Nombre del grupo de recursos"
  default = "kubernetes_rg" 
}

variable "service_name" {
  type = string
  description = "Nombre del grupo de recursos"
  default = "kube" 
}

variable "environment" {
  type = string
  description = "Nombre del ambiente"
  default = "unirdm" 
}

variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

variable "user_name" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "ansible"
}

variable "storage_type" {
  type = string
  description = "Tipo de disco a crear"
  default = "Standard_LRS"
}

variable "storage_name" {
  type = string
  description = "Tipo de disco a crear"
  default = "unirdm"
}




############################ CONFIGURACION NETWORK ##################################
variable "net_address_prefixes" {
  type = string
  default = "10.0.1.0/24" 
  description = "rango ip subnet"
}


variable "net_address_space" {
  type = string
  default = "10.0.0.0/16" 
  description = "Rango ip net"
}




#################################### CONFIGURACION DE IMAGEN SO ########################
variable "image_offer" {
  type = string
  description = "Tipo de disco a crear"
  #default = "centos-8-3-free" 
  default = "centos-8-stream-free" 
}

variable "image_sku" {
  type = string
  description = "Tipo de disco a crear"
  default = "centos-8-stream-free" 
  #default = "centos-8-3-free"
}

variable "image_publisher" {
  type = string
  description = "Tipo de disco a crear"
  default = "cognosys" 
}

variable "image_version" {
  type = string
  description = "Tipo de disco a crear"
  default = "1.2019.0810" 
}


