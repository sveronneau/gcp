# gcp/vault
Terraform and Ansible script to deploy Vault Consul 0.10.3 (Vanilla-configured, single instance, Initialized) within a GCP instance.

Requirements: Terraform and Ansible locally installed. GCP project, Service Account JSON file and Project wide SSH Key.

Ounce deployed, Vault will be Initialized. You can check the status with the following steps:

* SSH to your instance
* export VAULT_ADDR=http://127.0.0.1:8200
* vault status
