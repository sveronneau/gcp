// GCS backend for tfstae your_sa_file

terraform {
 backend "gcs" {
   bucket  = "<user>-terraform-admin"
   path    = "/terraform.tfstate"
   project = "<user>-terraform-admin"
 }
}
