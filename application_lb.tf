resource "aws_lb" "deploy_load_balancer" {
  name               = "sonar-alb"
  internal           = false
  load_balancer_type = "application"
#   security_groups    = ["sg-0f3afee3ae62bcc3b"]
  security_groups = [aws_security_group.web_server_sg_private1_tf.id]
  subnets            = [aws_subnet.deploy_subnet_public.id , aws_subnet.deploy_subnet_public2.id ]

}

resource "aws_lb_listener" "deploy_load_balancer" {
  load_balancer_arn = aws_lb.deploy_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.deploy_tg.arn
  }
}