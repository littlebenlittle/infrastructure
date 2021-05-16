variable "subnetwork" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "hostname" {
  type = string
}

variable "external_ip" {
  type = string
}

variable "disk_size" {
  type = number
  default = 10
}
