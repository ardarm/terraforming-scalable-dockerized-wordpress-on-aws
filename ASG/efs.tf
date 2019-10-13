resource "aws_efs_file_system" "wordpressfs" {
  creation_token = "wordpress-fs"


  tags {
    Name = "Wordpress FS"
    Project = "wordpress"
  }
}

resource "aws_efs_mount_target" "wordpress-a" {
  file_system_id = "${aws_efs_file_system.wordpressfs.id}"
  subnet_id      = "${aws_subnet.public-a.id}"
  security_groups = ["${aws_security_group.efs.id}"]
}


resource "aws_efs_mount_target" "wordpress-b" {
  file_system_id = "${aws_efs_file_system.wordpressfs.id}"
  subnet_id      = "${aws_subnet.public-b.id}"
  security_groups = ["${aws_security_group.efs.id}"]
}

output "efs-id" {
    value = "${aws_efs_file_system.wordpressfs.id}"
}
