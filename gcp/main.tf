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
  network_name    = var.gcp_docker_subnetwork_name
  subnetwork_name = var.gcp_docker_subnetwork_name
  allow_ssh_cidr  = locals.gcp_iap_cidr
}

module "ipfs-node" {
  source       = "./ipfs-node"
  subnetwork   = var.gcp_docker_subnetwork_name
  machine_type = var.gcp_docker_host_machine_type
  hostname     = var.gcp_docker_host_hostname
  external_ip  = var.gcp_docker_host_external_ip
  disk_size    = var.gcp_docker_host_disk_size
}
