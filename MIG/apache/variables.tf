# Creds and default location
variable "credentials" { default = "your_account.json" }
variable "project"     { default = "your_project_id" }
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
variable "name"               { default =  "instance-group-manager" }
variable "base_instance_name" { default =  "instance-group-manager" }
variable "target_size"        { default =  "3" }
#
# Firewall Rules

#
