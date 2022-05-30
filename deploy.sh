#!/bin/sh
terraform init
terraform apply -var-file="prod.tfvars"
aws eks --region us-southeast-1 update-kubeconfig --name skillrock-ks-cluster-all
echo "***************Creating namespaces******************"
kubectl create -f ./post_script/namespaces
echo "***************Creating Test Taking LCMS - Node Service, Deployment and PDB***************"
kubectl create -f ./post_script/services/ingress-controller
echo "***************Creating Logging configuration***************"
kubectl create -f ./post_script/logging
echo "***************Creating Metric Server***************"
kubectl create -f $HOME/aakash-terraform/post_script/metric-server