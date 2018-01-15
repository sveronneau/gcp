terraform {
 backend "gcs" {
   bucket  = "stacy-terraform-admin"
   path    = "/terraform.tfstate"
   project = "stacy-terraform-admin"
 }
}
