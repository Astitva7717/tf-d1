resource "aws_security_group" "lcms_sg" {
  name        = "lcms-common-sg-eks-${var.environment}"
  description = "Allow kubernetes custer traffic only"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self             = true
  }
  

  tags = {
    Product = "lcms"
    Environment = var.environment
  }
}

resource "aws_security_group" "tp_sg" {
  name        = "tp-common-sg-eks-${var.environment}"
  description = "Allow kubernetes custer traffic only"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    self             = true
  }
  

  tags = {
    Product = "tp"
    Environment = var.environment
  }
}

output "lcms_common_sg_eks_dev" {
  description = "ID of the LCMS Security Group ID "
  value       = aws_security_group.lcms_sg.id
}

output "tp_common_sg_eks_dev" {
  description = "ID of the TP Security Group ID "
  value       = aws_security_group.tp_sg.id
}