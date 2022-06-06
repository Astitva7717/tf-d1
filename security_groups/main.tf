resource "aws_security_group" "sapidblue_sg" {
  name        = "sapidblue-common-sg-eks-${var.environment}"
  description = "Allow kubernetes custer traffic only"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self             = true
  }
  

  tags = {
    Product = "sapidblue"
    Environment = var.environment
  }
}

output "sapidblue_common_sg_eks" {
  description = "ID of the Sapidblue Security Group ID "
  value       = aws_security_group.sapidblue_sg.id
}
