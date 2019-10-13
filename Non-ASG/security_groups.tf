resource "aws_security_group" "website" {
    name = "website"
    description = "Allow inbound traffic"
    vpc_id = "${aws_vpc.wordpress.id}"

    tags {
        Name = "website"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "database" {
    name = "database"
    description = "Allow inbound traffic"
    vpc_id = "${aws_vpc.wordpress.id}"

    tags {
        Name = "database"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups  = ["${aws_security_group.website.id}"]
    }

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups  = ["${aws_security_group.website.id}"]
    }

   
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}
