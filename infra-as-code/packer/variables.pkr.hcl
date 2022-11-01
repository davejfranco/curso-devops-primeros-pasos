variable "ad" {
  type = string
}

variable "base_image_ocid" {
  type    = string
  default = "ocid1.image.oc1.iad.aaaaaaaaorro6lk6mljfs3dafptdskbupyjjbindwgqc6nf4ohbe3ucklrqq"
}

variable "compartment_ocid" {
  type      = string
  sensitive = true
}

variable "ami_name" {
  type    = string
  default = "fastapi-demo-ami"
}

variable "vm_builder" {
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

variable "ssh_username" {
  type    = string
  default = "opc"
}

variable "subnet_ocid" {
  type      = string
  sensitive = true
}