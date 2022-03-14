variable "net_prefix_name" {
  type = string
  description = "Nombre del servio - Se utiliza como prefijo para el nombre de los recursos"
  default = "kube"   
}

variable "net_name" {
  type = string
  description = "Nombre del servio - Se utiliza para los nombres"
}


variable "rg_name" {
  type = string
  description = "Resource group name"
}

variable "rg_location" {
  type = string
  description = "Resource locations"
}

variable "net_environment" {
  type = string
  description = "Entorno"
}

variable "subnet_id" {
  type = string
  description = "Rango ip net"
}

variable "net_private_ip_address" {
  type = string
  description = "ip fija"
}

#variable "net_address_space" {
#  type = string
#  default = "10.0.0.0/16" 
#  description = "Rango ip net"
#}

#variable "net_address_prefixes" {
#  type = string
#  default = "10.0.1.0/24" 
#  description = "rango ip subnet"
#}


