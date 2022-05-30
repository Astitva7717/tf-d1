provider "aws" {
  version = ">= 3.50"
  region  = var.region
  assume_role {
        role_arn     = "arn:aws:iam::${var.ClientAWSAccountID}:role/Sapidblue-Terraform"
    }
}