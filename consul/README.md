# gcp/consul
Terraform and Ansible script to deploy Consul 1.0.6 within a GCP instance.

Requirements: GCP project and Project wide SSH Key

**STEPS**

If you are running Terraform inside a GCP instance running from a supported image, go to step 2

**Step 1 - Create service account in your GCP project**
* IAM & admin / Service accounts / Create Service Account
-      Roles: Compute Instance Admin (v1) / Service Account User / Storage Object Admin
-      Options / Create key / Download JSON file

**Step 2 - Download and Install Terraform**
* https://www.terraform.io/downloads.html

**Step 3 - Clone repo and adapt code**
* Clone GitHub Repo - https://github.com/sveronneau/gcp
* Adapt gcp/consul/consul.tf to fit your GCP identity file (or not), project, zone and Consul node count

**Step 4 - Enable GCP provider**
* terraform init gcp/consul

**Step 5 - Run script**
* terraform apply gcp/consul
* SSH to your node via GCP UI SSH and a Consul dev process will be there and can be checked with (consul info)

**Bingo!**
