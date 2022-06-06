provider "aws" {
  version = ">= 3.50"
  region  = var.region
  assume_role {
        role_arn     = "arn:aws:iam::577178473836:role/Sapidblue-Terraform"
    }
}