#!/bin/sh
export KUBE_CONFIG_PATH=$HOME/.kube/config
cd $HOME/skillrock-terraform-EKS
terraform init
# terraform plan -var-file="dev.tfvars" -exclude=module.albc
terraform apply -var-file="dev.tfvars" -exclude=module.albc
export KUBE_CONFIG_PATH=$HOME/.kube/config
terraform apply -var-file="dev.tfvars" -target=module.albc 
echo "***************Creating namespaces******************"
kubectl create -f $HOME/aakash-terraform/post_script/namespaces
echo "***************Creating Logging configuration***************"
kubectl create -f $HOME/aakash-terraform/post_script/logging
echo "***************Creating Test Taking LCMS - Node Service, Deployment and PDB***************"
kubectl create -f $HOME/aakash-terraform/post_script/apps
echo "***************Creating Metric Server***************"
kubectl create -f $HOME/aakash-terraform/post_script/metric-server
echo "***************Installing NewRelic Agent***************"
sh $HOME/aakash-terraform/post_script/newrelic/newrelic_deploy.sh