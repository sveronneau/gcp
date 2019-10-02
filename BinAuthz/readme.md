# Export current policy to YAML
gcloud container binauthz policy export  > policy.yaml
#
# Check and edit policy.yaml<br>Change ALWAYS_ALLOW to ALWAYS_DENY
nano policy.yaml
#
# Import your new policy
gcloud container binauthz policy import policy.yaml
#
# Testing the policy
kubectl apply -f deployment.yaml
#
# Change ENFORCED_BLOCK_AND_AUDIT_LOG to DRYRUN_AUDIT_LOG_ONLY
nano policy.yaml
#
# Dry-Run the policy
gcloud container binauthz policy import policy.yaml
