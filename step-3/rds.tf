resource "aws_db_subnet_group" "dbsubnetgroup" {
  name        = "database-subnet-group"
  description = "Our main group of subnets"
  subnet_ids  = ["${aws_subnet.private-a.id}", "${aws_subnet.private-b.id}"]
  tags {
    Project = "wp-devops"
  }
}


resource "aws_db_instance" "wp-database" {
  depends_on             = ["aws_security_group.web"]
  identifier             = "wp-database"
  allocated_storage      = "10"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "wp-database"
  username               = "wp-database"
  password               = "godblessuallthetime"
  multi_az               = "True"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.dbsubnetgroup.id}"
  tags {
    Project = "wp-devops"
  }
}

output "rdshost" {
  
  value = "${aws_db_instance.wp-database.address}"

}
