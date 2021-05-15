variable "network_name" {
  type = string
}

variable "subnetwork_name" {
  type = string
}

variable "allow_ssh_cidr" {
  type = list(string)
}
