variable "name" {
  description = "Project-prefix, e.g. \"demo\""
}

variable "instance_class" {
  description = "Jenkins instance class"
}

variable "vpc_id" {
  description = "The VPC the cluser should be created in"
}

variable "private_subnets" {
  description = "List of private subnet IDs"
}

