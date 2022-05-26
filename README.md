
## Prerequisite:-
1. Ubuntu machine
2. IAM Access key and Secret with EKS, VPN, IAM full access

## Steps:- 
1. Run build-tools.sh file in pre_script folder eg. sh build-tools.sh (this will install every tool required to deploy infra and application)
2. Run AWS configure command to add access key, secret and region
3. Add values in prod.tfvars/qa.tfvars or dev.tfvars
4. Go to tf_state_save folder
5. Give bucket name where the terraform state will be saved
6. run terrafom init and apply in the same folder with value file eg. terraform apply -var-file="prod.tfvars"
7. Open main.tf file in root folder and give the same name given in values file in line no 3, 8, 9
8. run terraform init , terraform plan and terraform apply with value file eg. terraform apply -var-file="prod.tfvars"



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


