resource "aws_route53_zone" "wpdevops" {
   name = "wpdevops" 
   force_destroy = true
}


resource "aws_route53_record" "www_cc" {
   zone_id = "${aws_route53_zone.wpdevops.zone_id}"
   name = "www.wpdevops.tk"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.docker.public_ip}"]
}

resource "aws_route53_record" "apex" {
  zone_id = "${aws_route53_zone.wpdevops.zone_id}"
  name    = "wpdevops.tk"
  type    = "A"

  alias {
    name                   = "www.wpdevops.tk"
    zone_id                = "${aws_route53_zone.wpdevops.zone_id}"
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
