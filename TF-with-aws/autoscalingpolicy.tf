# El autoscaling necesita 3 cosas: Un launchconfig, un autoscaling group y las políticas para hacer el autoscaling. Acá se definen estas políticas

# scale up alarm
resource "aws_autoscaling_policy" "example-cpu-policy" {
  name                   = "example-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  adjustment_type        = "ChangeInCapacity" # ????
  scaling_adjustment     = "1"                # Este número define si se va a incrementar o decrementar la cantidad de instancia
  cooldown               = "300"              # Este valor hace referencia a un tiempo en el que no existirá ningún autoscaling después de ejecutar la policy
  policy_type            = "SimpleScaling"    # Puede ser SimpleScaling, StepScaling o TargetTrackingScaling
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name          = "example-cpu-alarm"
  alarm_description   = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold" #El comparador de la policy
  evaluation_periods  = "2"                             # Después de cuantos períodos continuos siguiendo un patrón se debe hacer el autoscaling
  metric_name         = "CPUUtilization"                # El campo a evaluar
  namespace           = "AWS/EC2"
  period              = "120"     # Cada 2min va a ir a revisar el estado del CPU
  statistic           = "Average" # Busca que el promedio de los "evaluation_periods" sea la regla del policy. Puede ser algo más que average
  threshold           = "30"      # El valor a evaluar

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.example-cpu-policy.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "example-cpu-policy-scaledown" {
  name                   = "example-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaledown" {
  alarm_name          = "example-cpu-alarm-scaledown"
  alarm_description   = "example-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.example-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.example-cpu-policy-scaledown.arn]
}

