resource "aws_instance" "blueinstance" {
  count = var.enable_blue_env ? var.blue_instance_count : 0
  # ami = "ami-065deacbcaac64cf2"
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-a[0].id
  vpc_security_group_ids = [aws_security_group.allow-ssh-http.id]
  #key_name               = aws_key_pair.key.key_name
  user_data              = file("apacheblue.sh")
  tags = {
    Name = "blue-${count.index}"
  }
}