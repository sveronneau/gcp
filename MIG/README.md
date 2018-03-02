# gcp/MIG
Terraform script to create a an instance template and an instance group with a minimum of 3 NGINX instances running.  It also opens port 80 and 443 in firewall rules for default network for target with the tag nginx.

Scripts uses a GCP service account and a JSON file with your account token and ENV VARS

-- Apache folder contains a more complexe config with variables.tf
-- Apache-ilb folder contains a more complexe config with variables.tf, modules and using a internal load balancer
