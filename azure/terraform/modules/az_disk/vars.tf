
variable "disk_name" {
  type = string
  description = "Nombre del recurso disco" 
}

variable "rg_name" {
  type = string
  description = "Resource group name"
}

variable "rg_location" {
  type = string
  description = "Resource locations"
}

variable "environment" {
  type = string
  description = "Entorno"
}
