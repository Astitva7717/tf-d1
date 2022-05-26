data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "${var.name}-${var.environment}-jenkins"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "jenkins-sg" {
  name              = "${var.name}-${var.environment}-jenkins-sg"
  description       = "${var.name}-${var.environment}-jenkins-security group"
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "jenkins" {
  ami                           = data.aws_ami.ubuntu.id
  instance_type                 = var.instance_class
  subnet_id                     = var.private_subnet.id
  key_name                      = var.pemkey
  vpc_security_group_ids        = [aws_security_group.jenkins-sg.id]
  user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt install docker.io -y
sudo snap install docker -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
EOF
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Project = "${var.name}-${var.environment}"
  }
  depends_on = [ aws_security_group.jenkins-sg ]
}