resource "aws_lb" "my_lb" {
  count = terraform.workspace == "qa" ? 1:0
  name               = "my-lb-tf"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "qa"
  }
}
resource "aws_lb_target_group" "my_tg" {
count = terraform.workspace == "qa" ? 1:0
  name     = "my-lb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
health_check {
  protocol = "http"
  port = "80"
  healthy_threshold = 3
  interval = 10
   }
}
resource "aws_lb_listener" "my_listener" {
count = terraform.workspace == "qa" ? 1:0
load_balancer_arn = aws_lb.my_lb[0].arn
protocol = "http"
port = "80"
default_action {
    type = "forward"
    target_group_arn = aws_lb.my_lb[0].arn
  }
}
resource "aws_lb_target_group_attachment" "attaching" {
    count = terraform.workspace == "qa" ? 1:0
    target_group_arn = aws_lb.my_lb[0].arn
    target_id = aws_instance.my_server[count.index].id
    port = "80"
  
}
