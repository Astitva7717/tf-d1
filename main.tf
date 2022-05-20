terraform {
  required_version = "~>1.0.1"
  backend "s3" {
   bucket         = "skillrock-ks-cluster-state"
   key            = "state/terraform.tfstate"
   region         = "ap-southeast-1"
   encrypt        = true
   kms_key_id     = "alias/skillrock-ks-cluster-key"
   dynamodb_table = "skillrock-ks-cluster-state"
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

# module "security_group" {
#   source             = "./security_groups"
#   environment        = var.environment
#   vpc_id             = module.vpc.id
# }

module "eks" {
  source          = "./eks"
  name            = var.name
  environment     = var.environment
  region          = var.region
  k8s_version     = var.k8s_version
  vpc_id          = module.vpc.id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  kubeconfig_path = var.kubeconfig_path
}

# module "albc" {
#   source                    = "./albc"
#   name                      = var.name
#   environment               = var.environment
#   //aws_vpc_id                = module.vpc.id
#   aws_vpc_id                = var.input_vpc_id
#   aws_region_name           = var.region
#   alb_controller_depends_on = var.alb_controller_depends_on 
# }

# module "api_gateway" {
#   source              = "./api_gateway"
#   name                = var.name
#   environment         = var.environment
#   #main_domain         = var.main_domain
#   #api_certificate_arn = var.api_gateway_certificate_arn
#   #zone_id             = var.hosted_zone_id
# }