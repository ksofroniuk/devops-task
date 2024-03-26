resource "aws_lb_target_group" "lb_target_group" {
  name     = "tg-recngx"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_target_group_attachment" "linux_server_1" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = data.aws_instance.linux_server_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "linux_server_2" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.linux_server_2.id
  port             = 80
}

resource "aws_lb" "lb" {
  name               = "lb-recngx"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.security_group.id]
  subnets = [aws_subnet.subnet.id, aws_subnet.subnet_2.id]
}


resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}