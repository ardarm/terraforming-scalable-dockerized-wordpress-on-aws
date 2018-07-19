resource "aws_launch_configuration" "wp_scalling" {
  name_prefix          = "web_config"
  image_id      = "${data.aws_ami.ubuntu_ami.id}"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "wp-ap-southeast-1"
  security_groups=["${aws_security_group.web.id}"]
   user_data = "${data.template_file.bootstrap.rendered}"
}

resource "aws_autoscaling_group" "wp_group" {
  name                 = "wp-asg"
  launch_configuration = "${aws_launch_configuration.wp_launch.name}"
  min_size             = 2
  max_size             = 2
  vpc_zone_identifier = ["${aws_subnet.public-a.id}","${aws_subnet.public-b.id}"]
  load_balancers = ["${aws_elb.wp-devops.id}"]
  lifecycle {
    create_before_destroy = true
  }
}
