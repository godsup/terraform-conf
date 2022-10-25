resource "aws_lb_target_group" "blue" {
  name     = "blue-tg-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "blue" {
  count            = length(aws_instance.blueinstance)
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.blueinstance[count.index].id
  port             = 80
  depends_on       = [aws_instance.blueinstance]
}

resource "aws_lb_target_group" "green" {
  name     = "green-tg-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "green" {
  count            = length(aws_instance.greeninstance)
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.greeninstance[count.index].id
  port             = 80
  depends_on       = [aws_instance.greeninstance]
}

resource "aws_lb" "app" {
  name               = "app"
  internal           = false
  load_balancer_type = "application"
  subnets            = [for subnet in aws_subnet.public-a : subnet.id]
  security_groups    = [aws_security_group.allow-ssh-http.id]
  depends_on         = [aws_instance.blueinstance]
}

resource "aws_lb_listener" "alex-applb-listener" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    # target_group_arn = aws_lb_target_group.blue.arn
    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "blue", 100)
      }
      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = lookup(local.traffic_dist_map[var.traffic_distribution], "green", 0)
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}