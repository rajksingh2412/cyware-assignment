resource "aws_lb" "cyware-alb" {
  name               = "cyware-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ssh-allowed.id]
  subnets            = [aws_subnet.prod-subnet-public-1.id,aws_subnet.prod-subnet-public-2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}