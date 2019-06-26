# El launch configuration define qué características va a tener las instancias que se creen a raíz del autoscaling
# Este resource puede ser tratado igual que las instancias con respecto a los userdata
resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = "ami-024a64a6685d05041"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.allow-ssh.id]
}

# Este resource es la manera en la que será tratada este Autoscaling. 
# Se define la cantidad de instancias mínimas y máximas, las VPC a las que corresponderá, el launch configuration
resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300 # Define cada cuánto tiempo debe revisar la salud. En segundos
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

