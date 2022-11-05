output "domain_zone_id" {
  value = aws_route53_zone.primary.zone_id
}

output "server_ips" {
  value = aws_instance.web.*.public_ip
}

output "servers_names" {
  value = aws_route53_record.web.*.fqdn
}

