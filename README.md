# Terraform template for AWS EKS with Fargate profile

This terraform will be used to setup the AWS infrastructure
for a dockerized application running on EKS with a Fargate profile.

## Prerequisites
This requires `aws-iam-authenticator`

## System setup Install build tools 
1. sudo sh pre_script/buildtools.sh

## Terraform Infra setup Dev Variables environnement
1. terraform init
2. terraform plan -var-file="dev.tfvars"
3. terraform apply -var-file="dev.tfvars"

## Install applications 
1. sudo sh post_script/deploy.sh

## Destroy application
1. sudo sh destroy/destroy_all.sh
2. terraform destroy

## Deploy only single module
terraform apply -var-file="dev.tfvars" -target=module.redis 

## Exclude any module
terraform apply -var-file="dev.tfvars" -exclude=module.albc


