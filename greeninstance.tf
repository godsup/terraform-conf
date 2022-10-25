resource "aws_instance" "greeninstance" {
  count                  = var.enable_green_env ? var.green_instance_count : 0
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-a[0].id
  vpc_security_group_ids = [aws_security_group.allow-ssh-http.id]
  #key_name               = aws_key_pair.key.key_name
  user_data              = file("apachegreen.sh")
  tags = {
    Name = "green-${count.index}"
  }
}