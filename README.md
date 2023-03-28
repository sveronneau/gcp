[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/df040c4a-bc5b-4d55-ad14-16ac275ee225/repos/f6e8dc06-cb09-468d-9162-8aaed5628c90/branch/ecb80b65-eb01-484b-8faa-a63aa7d8ebc7)](https://dashboard.infracost.io/org/sveronneau/repos/f6e8dc06-cb09-468d-9162-8aaed5628c90)
# gcp
Collection of Packer, Terraform, Consul, Ansible and other GCP related sample scripts.
All Terraform and Packer scripts uses a GCP service account and a JSON file with your account token.  It assumes you've set the proper roles to your service account.

* consul - The blog post folder
*
* consul_vars - introducing variables.tf file to consul
* Create Master TF Project and SA
* Create Project
* gce (Compute engine)
* gcs-backend (enable gcs backend for terraform state file)
* gke (Kubernetes engine)
* MIG (Managed Instance Group)
* packer
* vault
* vpc and firewall
* CloudSQL
