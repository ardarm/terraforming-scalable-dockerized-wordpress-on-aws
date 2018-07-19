resource "aws_efs_file_system" "wpfs" {
  creation_token = "wp-fs"


  tags {
    Name = "wpfs"
    Project = "wp-devops"
  }
}

resource "aws_efs_mount_target" "wp-a" {
  file_system_id = "${aws_efs_file_system.wpfs.id}"
  subnet_id      = "${aws_subnet.public-a.id}"
  security_groups = ["${aws_security_group.efs.id}"]
}


resource "aws_efs_mount_target" "wp-b" {
  file_system_id = "${aws_efs_file_system.wpfs.id}"
  subnet_id      = "${aws_subnet.public-b.id}"
  security_groups = ["${aws_security_group.efs.id}"]
}

output "efs-id" {
    value = "${aws_efs_file_system.wpfs.id }"
}
