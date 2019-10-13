resource "aws_launch_configuration" "wp_launch" {
  name_prefix          = "web_config"
  image_id      = "${data.aws_ami.ubuntu_ami.id}"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "wordpress"
  security_groups=["${aws_security_group.website.id}"]
  user_data = "${data.template_file.bootstrap.rendered}"
}

resource "aws_autoscaling_group" "wp_group" {
  name                 = "wordpress-asg"
  launch_configuration = "${aws_launch_configuration.wp_launch.name}"
  desired_capacity     = 1
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier = ["${aws_subnet.public-a.id}","${aws_subnet.public-b.id}"]
  load_balancers = ["${aws_elb.wordpress.id}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "wordpresspolicy" {
  name                   = "wordpress-policy-high"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.wp_group.name}"
}

resource "aws_autoscaling_policy" "wordpresspolicylow" {
  name                   = "wordpress-policy-low"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.wp_group.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpuhigh" {
  alarm_name          = "wordpress-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.wp_group.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.wordpresspolicy.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cpulow" {
  alarm_name          = "wordpress-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "25"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.wp_group.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.wordpresspolicylow.arn}"]
}