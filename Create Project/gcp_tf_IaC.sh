#!/bin/bash
#
export TF_VAR_project_name=my_new_project
export TF_VAR_region=northamerica-northeast1
export TF_VAR_zone=northamerica-northeast1-a
export TF_VAR_network=foobar
#
terraform plan -out my_plan
#
