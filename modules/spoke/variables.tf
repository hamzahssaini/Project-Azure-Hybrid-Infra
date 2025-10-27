variable "prefix" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "address_space" {
  type = list(string)
}
variable "subnet_name" {
  type = string
}
variable "subnet_prefix" {
  type = string
}
variable "hub_vnet_id" {
  type = string
}
variable "hub_vnet_name" {
  type = string
}
variable "hub_rg_name" {
  type = string
}
variable "vm_admin_username" {
  type    = string
  default = "hamza"
}
variable "vm_admin_password" {
  type      = string
  sensitive = true
}
variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}
