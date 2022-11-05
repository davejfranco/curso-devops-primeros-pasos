variable "dns_zone" {
  type    = string
  default = "dave.com"
}

variable "ami" {
  type    = string
  default = "ami-005e54dee72cc1d00"
}

variable "server_numbers" {
  type    = number
  default = 2
}

variable "ec2_type" {
  type    = string
  default = "t3.micro"
}

variable "default_tags" {
  type = map(any)
  default = {
    Environment = "local"
    Provider    = "aws"
  }
}