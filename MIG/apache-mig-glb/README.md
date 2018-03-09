# gcp/MIG/apache-mig-glb
Terraform script to create a an instance template from a Packer built image followed by the creation of an instance group with a minimum of 3 Apache Server (no public IP) with a burst to 5 instances running.  It also opens port 80 and 443 in firewall rules for default network and is fronted by a Global LoadBalancer.  

Scripts uses a GCP service account and a JSON file with your account token and VARS defined in variables.tf

Once all is setup, hit the Load Balancer Public IP
