variable "location" {
  description = "Azure region for everything in this lab."
  type        = string
  default     = "uksouth"
}

variable "prefix" {
  description = "Short name used in every resource name."
  type        = string
}

variable "my_ip" {
  description = "Your public IP. Only this address can SSH in."
  type        = string
}

variable "ssh_public_key" {
  description = "Contents of ~/.ssh/id_ed25519.pub."
  type        = string
}

variable "vm_size" {
  description = "VM size for Thursday's lab."
  type        = string
  default     = "Standard_B1s"
}
