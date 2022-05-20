kubectl apply -f ./newrelic/px.dev_viziers.yaml && \
kubectl apply -f ./newrelic/olm_crd.yaml && \
helm repo add newrelic https://helm-charts.newrelic.com && helm repo update && \
kubectl create namespace newrelic ; helm upgrade --install newrelic-bundle newrelic/nri-bundle \
 --set global.licenseKey=<License Key> \
 --set global.cluster=tt-ks-cluster-dev \
 --namespace=newrelic \
 --set newrelic-infrastructure.privileged=true \
 --set ksm.enabled=true \
 --set prometheus.enabled=true \
 --set kubeEvents.enabled=true \
 --set logging.enabled=true \
 --set newrelic-pixie.enabled=true \
 --set newrelic-pixie.apiKey=01762101-b07a-4261-aaff-253659a65de9 \
 --set pixie-chart.enabled=true \
 --set pixie-chart.deployKey=182238b8-cb77-4977-a37f-f11cd6792752 \
 --set pixie-chart.clusterName=tt-ks-cluster-dev \
 --set global.fargate=true \
 --set newrelic-infra-operator.enabled=true