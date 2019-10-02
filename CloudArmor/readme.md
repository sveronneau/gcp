# Create Namespace
kubectl create namespace cloud-armor-how-to
#
# Deploy Workload
kubectl apply -f deployment.yaml
#
# Create CA Policy and Rules
gcloud beta compute security-policies create ca-how-to-security-policy --description "policy for Google Cloud Armor how-to topic"
gcloud beta compute security-policies rules create 1000 --security-policy ca-how-to-security-policy --description "Deny traffic from 192.0.2.0/24." --src-ip-ranges "192.0.2.0/24" --action "deny-404"
#
# Create BackendConfig that says which policy to use
kubectl apply -f backend-config.yaml
#
# Check Deployment and CA policy in UI
# Create Service with Annotation to BackEndconfig thus making the link between the BES and the CA Policy
kubectl apply -f service.yaml
#
# Reserve External IP and give it a name
gcloud compute addresses create cloud-armor-how-to-address --global
#
# Create Ingress that point to my BES abd uses the reserved external IP via Annotation.
kubectl create -f ingress.yaml
#
# Check policy in UI
