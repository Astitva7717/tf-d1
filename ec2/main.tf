data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["sb-test1"]
  }
}
resource "aws_instance" "ec2_public" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = var.vpc.public[0]
  tags = {
    "Name" = "${var.namespace}-EC2-PUBLIC"
  }

resource "aws_instance" "ec2_private" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = false
  instance_type               = "t2.micro"
  subnet_id                   = var.vpc.private[1]
  tags = {
    "Name" = "${var.namespace}-EC2-PRIVATE"
  }

}