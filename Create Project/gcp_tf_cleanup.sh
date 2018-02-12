#!/bin/bash
terraform destroy "my_plan"
#
gcloud projects delete ${TF_ADMIN}
#
gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/resourcemanager.projectCreator
#
gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com  --role roles/billing.user
#
