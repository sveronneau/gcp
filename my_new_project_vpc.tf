resource "google_compute_network" "default" {
  name                    = "foobar"
  description             = "TF created VPC"
  auto_create_subnetworks = "false"
  project                 = "${google_project_services.project.project}"
}

resource "google_compute_subnetwork" "subnet_na_e1" {
  name          = "subnet-na-east1"
  description   = "TF created Subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = "${google_compute_network.default.self_link}"
  region        = "northamerica-northeast1"
  project       = "${google_project_services.project.project}"
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = "foobar"
  project = "${google_project_services.project.project}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}
