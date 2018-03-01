# Creds and default location
variable "credentials" { default = "your_account.json" } // Change with you service account .json file
variable "project"     { default = "your_project_id" } // Your GCP Project ID
variable "region"      { default = "northamerica-northeast1" }
variable "zone"        { default = "northamerica-northeast1-a" }
#
# Instance Template
variable "prefix"       { default = "apache-" }
variable "desc"         { default = "This template is used to create Apache server instances." }
variable "tags"         { default = "webserver" }
variable "desc_inst"    { default = "Apache Web server instance" }
variable "machine_type" { default =  "n1-standard-1" }
variable "source_image" { default =  "apache" } //This is the family tag used when building the Golden Image with Packer.
variable "network"      { default =  "default" }
#
# Managed Instace Group
variable "mig_name"           { default =  "apache-mig" }
variable "base_instance_name" { default =  "apache" }
variable "target_size"        { default =  "3" }
#
# Firewall Rules
variable "fwr_name" { default = "allow-http-https-webserver" }
#
