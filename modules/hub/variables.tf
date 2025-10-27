variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

# Optionally allow customizing address space & subnet prefixes
variable "hub_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "gateway_subnet_prefix" {
  type    = string
  default = "10.0.1.0/27"
}

variable "bastion_subnet_prefix" {
  type    = string
  default = "10.0.2.0/24"
}

variable "firewall_subnet_prefix" {
  type    = string
  default = "10.0.3.0/26"
}

variable "monitor_subnet_prefix" {
  type    = string
  default = "10.0.4.0/24"
}
