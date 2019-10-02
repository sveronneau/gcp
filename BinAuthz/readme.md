# Export current policy to YAML
gcloud container binauthz policy export  > policy.yaml
#
# Check and edit policy.yaml<br>Change ALWAYS_ALLOW to ALWAYS_DENY
nano policy.yaml
#
# Import your new policy
gcloud container binauthz policy import policy.yaml
#
# Testing the policy (Deployment will fail)
kubectl apply -f deployment.yaml
#
# Change ENFORCED_BLOCK_AND_AUDIT_LOG to DRYRUN_AUDIT_LOG_ONLY
nano policy.yaml
#
# Dry-Run the policy (Deployment will work)
gcloud container binauthz policy import policy.yaml
#
# Loook for dry-run in StackDriver Logging (Kubernetes Cluster / Filter: dry-run)
