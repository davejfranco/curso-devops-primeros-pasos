variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {
  type    = string
  default = "us-ashburn-1"
}

variable "label_prefix" {
  type    = string
  default = "demo"
}
variable "compartment_id" {
  type = string
}

variable "vcn_name" {
  type    = string
  default = "demo-vcn"
}

variable "igw_name" {
  type    = string
  default = "demo-vcn-igw"
}

#Compute
variable "vm_config" {
  type = object({
    shape  = string
    ocpu   = number
    memory = number
  })

  default = {
    shape  = "VM.Standard.E4.Flex"
    ocpu   = 1
    memory = 2
  }
}

variable "ami_ocid" {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaah3e2jx7bu6katzh4y3bo5hjbnyftarn5sklmwta5by7n4kdbalqa"
}

variable "docker_api_version" {
  type = string
  default = "latest"
}

variable "docker_image" {
  type = string
  default = "davejfranco/python-fast-api"
}