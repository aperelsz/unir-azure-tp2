
variable "nic_id" {
  type = string
  description = "Id nick asociar"
  
  validation {
    condition = length(var.nic_id) > 0
    error_message = "Se debe asignar un ID de red valido."
  }
}

variable "permitir_ssh" {
  type = bool
  description = "Indica si se habilita el ssh"
  default = true
}

variable "security_name" {
  type = string
  description = "Nombre del servio - Se utiliza para los nombres"
}

variable "rules" {
  type = map(object({
      ruleName = string
      rangePortSource = string
      rangePortDest = string
      priority = number
    })
  )
  description = "Nombre de la regla"
  nullable = true 
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