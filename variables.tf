variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "location" {
  type    = string
  default = "UK South"
}

variable "prefix" {
  type    = string
  default = "hamza"
}

variable "tags" {
  type = map(string)
  default = {
    owner       = "Hamza"
    environment = "dev"
    project     = "hub-spoke-architecture"
  }
}
