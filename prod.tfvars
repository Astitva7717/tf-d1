##  Name of your stack, e.g. demo
name     = "skillrock"

## Name of your environment, e.g. prod
environment     = "all"

## AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
region     = "ap-southeast-1"
#############################################################################################
## A comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
availability_zones     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

# CIDR block for the VPC
cidr     = "10.104.0.0/16"

## List of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
private_subnets     = ["10.104.0.0/20", "10.104.32.0/20", "10.104.64.0/20"]

## List of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
public_subnets     = ["10.104.16.0/20", "10.104.48.0/20", "10.104.80.0/20"]

## Path where the config file for kubectl should be written to
kubeconfig_path     = "~/.kube"
##############################################################################################################
## A comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
## Kubernetes version
k8s_version = "1.21"

# Variables for AWS Load Balancer Controller
######################################
alb_controller_depends_on = "fp-default"