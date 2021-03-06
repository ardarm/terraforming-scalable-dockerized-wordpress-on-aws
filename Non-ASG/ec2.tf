resource "aws_instance" "docker" {
   ami = "${data.aws_ami.ubuntu_ami.id}"
   instance_type = "t2.micro"
   subnet_id = "${aws_subnet.public-a.id}"
   associate_public_ip_address = true
   key_name = "wordpress"
   vpc_security_group_ids=["${aws_security_group.website.id}"]
   #iam_instance_profile = "${aws_iam_instance_profile.web_profile.name}"
   user_data = "${data.template_file.bootstrap.rendered}"

}

##Lookup AMI

data "aws_ami" "ubuntu_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

  owners = ["099720109477"] # Canonical
}

output "bastion_address" {
    value = "${aws_instance.docker.public_dns}"
}


data "template_file" "bootstrap" {
    template = "${file("bootstrap.tpl")}"
      vars {
        dbhost = "${aws_db_instance.wpdb.address}"
  }
}