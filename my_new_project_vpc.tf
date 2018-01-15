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

