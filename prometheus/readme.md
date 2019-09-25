Installing Prometheus (from CloudShell)

Make yourself cluster-admin

ACCOUNT=$(gcloud info --format='value(config.account)')
kubectl create clusterrolebinding owner-cluster-admin-binding \ --clusterrole cluster-admin --user $ACCOUNT
Create a Prometheus namespace
kubectl create namespace prometheus
Give the namespace cluster-reader permission
wget \ https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/clusterRole.yaml 
kubectl create -f clusterRole.yaml
Create the configMap
wget \ https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/config-map.yamlà


kubectl create -f configMap.yaml -n prometheus
Create the Deployment
Get the latest version information from https://github.com/prometheus/prometheus/releases/ 
wget \ https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/prometheus-deployment.yaml
Change the version in the YAML file to reflect the latest version
kubectl create -f prometheus-deployment.yaml -n prometheus
kubectl get pods -n prometheus
kubectl port-forward prometheus-deployment-your_pod_info 8080:9090 -n prometheus
Open Web preview in CloudShell
export KUBE_NAMESPACE=prometheus
export KUBE_CLUSTER=<my cluster-name>
export GCP_REGION=<my region>
export GCP_PROJECT=<my project ID>
export DATA_DIR=/prometheus/
export DATA_VOLUME=prometheus-storage-volume
export SIDECAR_IMAGE_TAG=0.6.0
wget https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/patch.sh
chmod 775 patch.sh
sh ./patch.sh deployment prometheus-deployment
kubectl get pods -n prometheus
You can now explore those metrics in stackdriver
https://github.com/sveronneau/gcp/blob/master/prometheus/metrics.png
