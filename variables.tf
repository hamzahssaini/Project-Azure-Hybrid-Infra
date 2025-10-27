variable "location" {
  type    = string
  default = "France Central"
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
