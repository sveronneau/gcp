# gcp/consul
Terraform and Ansible script to deploy Consul within a GCP instance.

Requirements: GCP project and Project wide SSH Key

**STEPS**

If you are running Terraform inside a GCP instance running from a supported image, go to step 2

**Step 1 - Create service account in your GCP project**
* IAM & admin / Service accounts / Create Service Account
-      Roles: Compute Instance Admin (v1) / Service Account Admin / Storage Object Admin
-      Options / Create key / Download JSON file

**Step 2 - Download and Install Terraform**
* https://www.terraform.io/downloads.html
* Clone GitHub Repo - https://github.com/sveronneau/gcp/tree/master/consul
* Adapt consul.tf to fit your GCP identity file (or not), project, zone and Consul node count

**Step 3 - Enable GCP provider**
* terraform init

**Step 4 - Run script**
* terraform apply
* SSH to your node and a Consul dev process will be there and can be checked with (consul info)

**Bingo!**
