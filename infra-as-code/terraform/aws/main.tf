data "aws_region" "current" {}

resource "aws_route53_zone" "primary" {
  name = var.dns_zone
}

resource "aws_instance" "web" {
  count         = var.server_numbers
  ami           = var.ami
  instance_type = var.ec2_type

  tags = merge(
    {
      Name = "webserver-${count.index}"
    }, var.default_tags
  )
}

resource "aws_route53_record" "web" {
  count   = var.server_numbers
  zone_id = aws_route53_zone.primary.id
  name    = "webserver-${count.index}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.web[count.index].public_ip]

}