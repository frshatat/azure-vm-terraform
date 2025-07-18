variable "vm_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "vm_size" {}
variable "ssh_public_key_path" {}
variable "subnet_id" {}
variable "script_url" {
  description = "URL where the install script is hosted"
  type        = string
}
variable "admin_username" {
  description = "VM admin username"
  type        = string
}