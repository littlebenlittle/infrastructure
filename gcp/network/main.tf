resource "google_compute_network" "net" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnetwork_name
  network       = var.network_name
  ip_cidr_range = "10.0.0.0/29"
}

resource "google_compute_firewall" "allow_ssh" {
  name     = "${var.network_name}-allow-ssh"
  network  = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.allow_ssh_cidr
}

resource "google_compute_firewall" "allow-internet" {
  name     = "${var.network_name}-allow-internet"
  network  = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}
