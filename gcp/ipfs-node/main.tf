resource "google_compute_address" "docker_host_external_ip" {
  name     = "docker-host"
  address  = var.external_ip
}

resource "google_compute_disk" "docker_host" {
  name     = "docker-host"
  type     = "pd-ssd"
  image    = "cos-cloud/cos-stable"
  size     = var.disk_size
}

resource "google_compute_instance" "docker_host" {
  name         = "docker-host"
  machine_type = var.machine_type
  metadata = {
    enable-oslogin = "TRUE"
    user-data      = local.cloud_config
  }
  allow_stopping_for_update = true
  boot_disk {
    source = google_compute_disk.docker_host.id
  }
  network_interface {
    subnetwork = var.subnetwork
    access_config {
      nat_ip = var.external_ip
    }
  }
}
