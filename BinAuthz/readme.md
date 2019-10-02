# Export current policy to YAML
gcloud container binauthz policy export  > policy.yaml
#
# Check and edit policy.yaml (Change ALWAYS_ALLOW to ALWAYS_DENY)
nano policy.yaml
#
# Import your new policy
gcloud container binauthz policy import policy.yaml
#
# Testing the policy
kubectl apply -f deployment.yaml
