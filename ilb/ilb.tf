// https://cloud.google.com/community/tutorials/modular-load-balancing-with-terraform

provider "google" {
  credentials = "${file("gcp_service_account.json")}"
  project = "your_gcp_project"
  region  = "northamerica-northeast1"
}
