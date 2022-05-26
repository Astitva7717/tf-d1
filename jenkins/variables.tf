variable "name" {
  description = "Project-prefix, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "instance_class" {
  description = "Jenkins instance class"
}

variable "vpc_id" {
  description = "The VPC the cluser should be created in"
}

variable "private_subnet" {
  description = "List of private subnet IDs"
}

variable "pamkey" {
  description = "Pam file name for jenkins ec2 instance"
}
