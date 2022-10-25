#This file is for configurating security groups
#This configuration allows ssh connection to the instances and 
#HTTP connection so you can access the the webpage

resource "aws_security_group" "allow-ssh-http" {
  vpc_id = aws_vpc.vpc.id
  name   = "allow-ssh"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh and html"
  }
}