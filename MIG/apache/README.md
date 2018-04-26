# gcp/MIG/apache
Terraform script to create a an instance template from a Packer built image followed by the creation of an instance group with a minimum of 3 Apache Server with a burst to 5 instances running.  It also opens port 80 and 443 in firewall rules for default network for target with the tag webserver.

Scripts uses a GCP service account and a JSON file with your account token and VARS defined in variables.tf

The Image used for template creation can be create with Packer and this script 
https://github.com/sveronneau/gcp/blob/master/packer/apache.json
