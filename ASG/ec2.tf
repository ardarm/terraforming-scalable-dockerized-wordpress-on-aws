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

data "template_file" "bootstrap" {
    template = "${file("bootstrap.tpl")}"
      vars {
        dbhost = "${aws_db_instance.wpdb.address}"
        efsid = "${aws_efs_file_system.wordpressfs.id}"
  }
}
