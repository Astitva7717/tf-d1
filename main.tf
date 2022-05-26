terraform {
  required_version = "~>1.0.1"
  backend "s3" {
   bucket         = "mohit-ks-cluster-state"
   key            = "state/terraform.tfstate"
   region         = "ap-southeast-1"
   encrypt        = true
   kms_key_id     = "alias/mohit-ks-cluster-key"
   dynamodb_table = "mohit-ks-cluster-state"
 }
}

provider "aws" {
  version = ">= 3.50"
  region  = var.region
}

module "vpc" {
  source             = "./vpc"
  name               = var.name
  environment        = var.environment
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}


module "eks" {
  source          = "./eks"
  name            = var.name
  environment     = var.environment
  region          = var.region
  k8s_version     = var.k8s_version
  vpc_id          = module.vpc.id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  fargate_namespace = var.fargate_profile_namespace
  kubeconfig_path = var.kubeconfig_path
}

# module "api_gateway" {
#   source              = "./api_gateway"
#   name                = var.name
#   environment         = var.environment
#   #main_domain         = var.main_domain
#   #api_certificate_arn = var.api_gateway_certificate_arn
#   #zone_id             = var.hosted_zone_id
# }