terraform {
  required_version = "~>1.0.1"
  backend "s3" {
   bucket         = "sapidblue-ks-cluster-all-state"
   key            = "state/terraform.tfstate"
   region         = "ap-south-1"
   encrypt        = true
   kms_key_id     = "alias/sapidblue-ks-cluster-all-state"
   dynamodb_table = "sapidblue-ks-cluster-all-state"
 }
}
