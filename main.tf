resource "google_service_account" "default" {
  account_id   = "${var.name}-${var.service_account_id}"
  display_name = "${var.name}-${var.service_account_id}"
  project      = var.project_id
}

resource "google_compute_instance" "default" {
  name         = "my-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.boot_disk_image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // This section is to give the VM an external ip address.
    }
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1> Welcome! The GCP-VM has been successfully provisioned.!</h1></body></html>' | sudo tee /var/www/html/index.html"

  tags = ["http-server"]
}

resource "google_compute_firewall" "http-server" {
  name    = "allow-http"
  network = "default"

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