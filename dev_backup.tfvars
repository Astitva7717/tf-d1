##  Name of your stack, e.g. demo
name     = "tt"

## Name of your environment, e.g. prod
environment     = "dev"

## AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
region     = "us-east-1"
#############################################################################################
## A comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]

## CIDR block for the VPC
cidr     = "10.104.0.0/16"

## List of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
private_subnets     = ["10.104.0.0/20", "10.104.32.0/20", "10.104.64.0/20"]

## List of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
public_subnets     = ["10.104.16.0/20", "10.104.48.0/20", "10.104.80.0/20"]

## Co-Lo Security Group id
colo_security_group_id = "sg-04519862d5f6a5f94"

## Path where the config file for kubectl should be written to
kubeconfig_path     = "~/.kube"
##############################################################################################################
## A comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
input_availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]

## CIDR block for the VPC
input_cidr     = "10.0.0.0/16"

## List of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
input_private_subnets     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]

## List of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
input_public_subnets     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
##############################################################################################################

## Kubernetes version
k8s_version = "1.21"


# Variables for RDS
######################################
## Name of rds instance, e.g. demo
rds_name            = "tt-lcms-rds-eks"
rds_proxy_name      = "tt-lcms-rds-proxy-eks"
rds_secret_name     = "tt-tp-lcms-rds-secret-mgr-eks"
proxy_secret_arn    = "arn:aws:secretsmanager:us-east-1:910393620193:secret:tt-tp-lcms-rds-secret-mgr-eks-dev-jEyMUR"
rds_username        = "aakash"
rds_userpassword    = "aakashTestPlayer"
rds_instance_class  = "db.t3.medium"


# Variables for ELK
######################################
domain = "tt-tp-elastic-s-eks"
master_user_name = "admin"
master_user_password = "Password@123"
elk_instance_type = "t3.medium.elasticsearch"


# Variables for DocumentDB
######################################
docdb_name     = "tt-lcms-mongodb-eks"
docdb_user_name = "aakash"
docdb_user_password = "Password123"
docdb_reader_instance_class = "db.r5.large"
docdb_writer_instance_class = "db.t3.medium"


# Variables for Radis
######################################
redis_name     = "tt-lcms-redis-eks"
radis_node_type = "cache.t3.medium"


# Variables for S3 Bucket
######################################
bucket_name     = "contentaakash-tt-lcms-s3-private-eks"

# Variables for Kinesis Delivery Stream
######################################
kinesis_name    = "tt-tp-lcms-kinesis-delivery-streams-test-eks"


# Variables for dynamo DB
######################################
dynamo1_name     = "tt-tp-DynmoDB-lastSubmissions-eks"
dynamo2_name     = "tt-tp-DynmoDB-testEngineAllSubmissions-eks"


# Variables for WAF Regional
######################################
waf_regional_name     = "tt-waf-regional-eks"

# Variables for WAF Global
######################################
waf_global_name     = "tt-waf-global-eks"


# Variables for Lambda Function name
######################################
lambda_name     = "tt-tp-lambda-testplayer-submit-eks"

# Variables for Lambda Python Function name
######################################
lambda_python_name     = "tt-tp-lcms-lambda-auto-confirm-phone-number-test-eks"


# Variables for SQS1 name
######################################
sqs1_name     = "tt-tp-sqs-01-eks"
sqs2_name     = "tt-tp-sqs-02-eks"


# Variables for Cognito name
######################################
cognito_name     = "tt-tp-cognito-eks-test"


# Variables for API_Gateway
######################################
api_name     = "tt-apig-eks"
#########Aakash aakash.ac.in#############
api_gateway_certificate_arn =  "arn:aws:acm:us-east-1:910393620193:certificate/ed44a905-ac64-46eb-85e5-d9377b1556e9"

main_domain = "aakash.ac.in"
api_gateway_subdomain = "tt-apig-eks-dev"
hosted_zone_id = "Z15PO0NZHQ5WOZ"


# Variables for Cloud Front
######################################
cdn_subdomain = "tt-eks-dev" 

# Variables for AWS Load Balancer Controller
######################################
alb_controller_depends_on = "fp-default"
