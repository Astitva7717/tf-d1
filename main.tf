module "vpc" {
  source             = "./vpc"
  name               = var.name
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}

module "ec2" {
  source          = "./ec2"
  name            = var.name
  region          = var.region
  vpc_id          = module.vpc.id
  private_subnets = module.vpc.private
  public_subnets  = module.vpc.public
}
s