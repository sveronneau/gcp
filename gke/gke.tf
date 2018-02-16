provider "google" {
  credentials = "${var.credentials}"
  project = "${var.project}"
  region  = "${var.region}"
}

data "google_container_engine_versions" "canada" {
  zone = "${var.zone}"
}

// Store state file in memory and the rest is encrypted in flight and at rest in GCS
# data "terraform_remote_state" "foo" {
#   backend = "gcs"
#   config {
#     credentials = "your_json_creds"
#     bucket      = "your_state_pucket"
#     prefix      = "terraform/state/gke_cluster_name"
#   }
# }

resource "google_container_cluster" "primary" {
  name               = "${var.gke_cluster_name}"
  zone               = "${var.zone}"
  // Get the latest version all the time
  #node_version       = "${data.google_container_engine_versions.canada.latest_node_version}"
  #min_master_version = "${data.google_container_engine_versions.canada.latest_node_version}"
  //
  node_version       = "${var.gke_cluster_node_version}"
  min_master_version = "${var.gke_cluster_min_master_version}"
  //
  initial_node_count = "${var.gke_cluster_node_count}"

#  additional_zones = [
#    "northamerica-northeast1-b",
#    "northamerica-northeast1-c",
#  ]

// DONT USE THIS IN PROD IF STATE FILE IS LOCAL (plain-text JSON)
  master_auth {
    username = "${var.gke_cluster_user}"
    password = "${var.gke_cluster_pwd}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      foo = "first_gke_app"
    }

    tags = ["test", "build1"]
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
