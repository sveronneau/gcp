# gcp/MIG
Terraform script to create a an instance template, an instance group with a minimum of 3 running instances.  
It also opens port 80 and 443 in firewall rules for default network.

Scripts uses a GCP service account and a JSON file with your account token and ENV VARS

-- apache folder contains basic template and Managed Instance Group
-- apache-mig-glb folder contains a more complexe config. It contains everything from the apache folder but spreads the MIG in 3 zones and fronts everything with a Global Load Balancer
