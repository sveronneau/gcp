<b>---Installing Prometheus (from GCP CloudShell)---</b>

<b>Make yourself cluster-admin</b>

ACCOUNT=$(gcloud info --format='value(config.account)')<br>
kubectl create clusterrolebinding owner-cluster-admin-binding --clusterrole cluster-admin --user $ACCOUNT

<b>Create a Prometheus namespace</b><br>
kubectl create namespace prometheus

<b>Give the namespace cluster-reader permission</b><br>
wget \ https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/clusterRole.yaml <br>
kubectl create -f clusterRole.yaml<br>

<b>Create the configMap</b><br>
wget \ https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/config-map.yaml <br>
kubectl create -f configMap.yaml -n prometheus

<b>Create the Deployment</b><br>
Get the latest version information from https://github.com/prometheus/prometheus/releases/ <br>
wget https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/prometheus-deployment.yaml <br>

<b>Change the version in the YAML file to reflect the latest version</b><br>
kubectl create -f prometheus-deployment.yaml -n prometheus<br>
kubectl get pods -n prometheus<br>
kubectl port-forward prometheus-deployment-your_pod_info 8080:9090 -n prometheus<br>
Open Web preview in CloudShell

<b>Install Stackdriver Collector</b><br>
export KUBE_NAMESPACE=prometheus<br>
export KUBE_CLUSTER=my cluster-name<br>
export GCP_REGION=my region<br>
export GCP_PROJECT=my project ID<br>
export DATA_DIR=/prometheus/<br>
export DATA_VOLUME=prometheus-storage-volume<br>
export SIDECAR_IMAGE_TAG=0.6.0<br>
wget https://raw.githubusercontent.com/sveronneau/gcp/master/prometheus/patch.sh <br>
chmod 775 patch.sh <br>
sh ./patch.sh deployment prometheus-deployment <br>
kubectl get pods -n prometheus <br>

<b>You can now explore those metrics in Stackdriver</b><br>
https://github.com/sveronneau/gcp/blob/master/prometheus/metrics.png
