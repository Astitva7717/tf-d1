terraform {
  required_version = "~>1.0.1"
  backend "s3" {
   bucket         = "ks-cluster-all-state"
   key            = "state/terraform.tfstate"
   region         = "ap-southeast-1"
   encrypt        = true
   kms_key_id     = "alias/ks-cluster-all-state"
   dynamodb_table = "ks-cluster-all-state"
 }
}
