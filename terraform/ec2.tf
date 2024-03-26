resource "aws_eip" "eip" {
  domain = "vpc"
}

data "aws_ami" "ubuntu_20240229" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20240229"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "linux_server_2" {
  ami                    = data.aws_ami.ubuntu_20240229.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet_2.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  user_data              = file("vm-init.sh")

  tags = {
    Name = "recngx02"
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.linux_server_2.id
  allocation_id = aws_eip.eip.id
}
