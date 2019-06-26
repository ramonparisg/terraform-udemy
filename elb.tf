resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id] # Vive en dos ip públicas
  security_groups = [aws_security_group.elb-securitygroup.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true # Como el ELB está en dos ip públicas, se debe habilitar esto
  connection_draining         = true # Esto habilita que se destruyan instancias
  connection_draining_timeout = 400  # El timegap desde que se manda la señal de destruirla hasta que se destruye
  tags = {
    Name = "my-elb"
  }
}

