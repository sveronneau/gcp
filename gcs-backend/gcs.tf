provider "google" {
  credentials = "${file("path_to_your_json_file")}"
  project     = "your_project"
  region      = "northamerica-northeast1"
}

terraform {
  backend "gcs" {
    credentials = "path_to_your_json_file"
    bucket  = "your_bucket_name" // Needs to exist prior execution of script
    prefix  = "terraform/tfstate"
  }
}
