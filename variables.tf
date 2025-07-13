variable "location" {
  default = "eastus"
}

variable "resource_group_name" {
  default = "cf-agent-rg"
}

variable "admin_username" {
  default = "faris"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
