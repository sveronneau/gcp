// Configure the Google Cloud provider

provider "google" {
  credentials = "${file("/home/stacy/TF/GKE/account.json")}"
  project = "terraform-sandbox-194417"
  region  = "northamerica-northeast1"
}

resource "google_container_cluster" "primary" {
  name               = "marcellus-wallace"
  zone               = "northamerica-northeast1-a"
  initial_node_count = 3

#  additional_zones = [
#    "northamerica-northeast1-b",
#    "northamerica-northeast1-c",
#  ]

  master_auth {
    username = "mr.yoda"
    password = "adoy.r23r43dsf524m"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      foo = "bar"
    }

    tags = ["foo", "bar"]
  }
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
