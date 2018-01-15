#!/bin/bash
# 
export TF_VAR_org_id=907565456311
export TF_VAR_billing_account=0104BF-0E14A9-484586
export TF_ADMIN=${USER}-terraform-admin
export TF_CREDS=~/.config/gcloud/terraform-admin.json
#
# CREATE TF PROJECT
gcloud projects create ${TF_ADMIN} --organization ${TF_VAR_org_id} --set-as-default
gcloud beta billing projects link ${TF_ADMIN} --billing-account ${TF_VAR_billing_account}
# 
# CREATE TF service account
gcloud iam service-accounts create terraform --display-name "Terraform admin account"
gcloud iam service-accounts keys create ${TF_CREDS} --iam-account terraform@${TF_ADMIN}.iam.gserviceaccount.com
#
# Grant the service account permission to view the Admin Project and manage Cloud Storage:
gcloud projects add-iam-policy-binding ${TF_ADMIN} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/viewer
gcloud projects add-iam-policy-binding ${TF_ADMIN} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/storage.admin
#
# Any actions that Terraform performs require that the API be enabled to do so. In this guide, Terraform requires the following:
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
#
#Add organization/folder-level permissions
#Grant the service account permission to create projects and assign billing accounts:
gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/resourcemanager.projectCreator
gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/billing.user
#
# If your billing account is owned by another organization, then make sure the service account email has been added as a Billing Account User to the billing account permissions.
#
# Create the remote backend bucket in Cloud Storage and the backend.tf file for storage of the terraform.tfstate file:
gsutil mb -p ${TF_ADMIN} gs://${TF_ADMIN}
cat > backend.tf <<EOF
terraform {
 backend "gcs" {
   bucket  = "${TF_ADMIN}"
   path    = "/terraform.tfstate"
   project = "${TF_ADMIN}"
 }
}
EOF
#
# Enable versioning for said remote bucket:
gsutil versioning set on gs://${TF_ADMIN}
#
# Configure your environment for the Google Cloud Terraform provider:
export GOOGLE_APPLICATION_CREDENTIALS=${TF_CREDS}
export GOOGLE_PROJECT=${TF_ADMIN}
#
# initialize the backend:

terraform init
#
