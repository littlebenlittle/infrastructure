variable "gcp_project" {
  type = string
}

variable "gcp_compute_region" {
  type = string
}

variable "gcp_compute_zone" {
  type = string
}

variable "gcp_creds_file" {
  type = string
}

variable "gcp_network_name" {
  type = string
}

variable "gcp_subnetwork_name" {
  type = string
}

variable "gcp_docker_host_machine_type" {
  type = string
}

variable "gcp_docker_host_hostname" {
  type = string
}

variable "gcp_docker_host_disk_size" {
  type    = number
  default = 10
}
