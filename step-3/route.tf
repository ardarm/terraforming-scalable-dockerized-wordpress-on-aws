resource "aws_route53_zone" "wpdevops" {
   name = "wp.devops" 
   force_destroy = true
}


resource "aws_route53_record" "www_cc" {
   zone_id = "${aws_route53_zone.wpdevops.zone_id}"
   name = "www.wp-devops.tk"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.wpdevops.dns_name}"]
}

resource "aws_route53_record" "apex" {
  zone_id = "${aws_route53_zone.wpdevops.zone_id}"
  name    = "h"
  type    = "A"

 alias {
    name                   = "${aws_elb.wordpress.dns_name}"
    zone_id                = "${aws_elb.wordpress.zone_id}"
    evaluate_target_health = "false"
  }
}

output "nameserver.1" {
    value = "${aws_route53_zone.wpdevops.name_servers.0}"
}

output "nameserver.2" {
    value = "${aws_route53_zone.wpdevops.name_servers.1}"
}

output "nameserver.3" {
    value = "${aws_route53_zone.wpdevops.name_servers.2}"
}

output "nameserver.4" {
    value = "${aws_route53_zone.wpdevops.name_servers.3}"
}
