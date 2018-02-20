# gcp/vault
Terraform and Ansible script to deploy Vault Consul 0.9.3 (Vanilla-configured, single instance, Initialized) within a GCP instance.

Requirements: Terraform and Ansible locally installed. GCP project, Service Account JSON file and Project wide SSH Key.

Ounce deployed, you need to initialize Vault by running the following commands:

* SSH to your instance
* export VAULT_ADDR=http://127.0.0.1:8200
* vault status
