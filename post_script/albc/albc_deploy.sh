#!/bin/sh
helm repo add eks https://aws.github.io/eks-charts
#helm install aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=aakash-test-player-prod -n kube-system --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
helm install aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=ugro-api-ks-cluster-prod -n kube-system