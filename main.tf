
resource "google_compute_instance" "default" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.boot_disk_image
    }
  }

  network_interface {
    network = var.network

    access_config {
      // This section is to give the VM an external ip address.
    }
  }

  tags = ["http-server"]



}

resource "google_compute_firewall" "http-server" {
  name    = "allow-http"
  network = var.network
  project      = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

output "ip" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}