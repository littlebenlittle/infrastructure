terraform {
  backend "gcs" {
    bucket  = "tf-state-staging-wfxk98m4"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = var.gcp_project
  region      = var.gcp_compute_region
  zone        = var.gcp_compute_zone
  credentials = file(var.gcp_creds_file)
}

module "network" {
  source          = "./network"
  network_name    = var.gcp_network_name
  subnetwork_name = var.gcp_subnetwork_name
  allow_ssh_cidr  = [local.gcp_iap_cidr]
}

module "docker_host" {
  source       = "./gcp-docker-host"
  subnetwork   = var.gcp_subnetwork_name
  machine_type = var.gcp_docker_host_machine_type
  hostname     = var.gcp_docker_host_hostname
  external_ip  = ""
  disk_size    = var.gcp_docker_host_disk_size
}
