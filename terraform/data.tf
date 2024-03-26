data "aws_instance" "linux_server_1" {
  instance_id = "i-0dcbf4c22b45d57b4"

  filter {
    name   = "tag:Name"
    values = ["recngx01"]
  }
}