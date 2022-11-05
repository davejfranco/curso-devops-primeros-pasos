#ssh key
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "oci_core_instance" "web_1" {
  #Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  shape               = var.vm_config.shape

  display_name = "web-1"

  create_vnic_details {
    #Optional
    assign_public_ip = true
    subnet_id        = oci_core_subnet.public_1.id
  }

  shape_config {
    #Optional
    memory_in_gbs = var.vm_config.memory
    ocpus         = var.vm_config.ocpu
  }
  source_details {
    #Required
    source_id   = var.ami_ocid
    source_type = "image"
  }

  #ssh key
  metadata = {
    ssh_authorized_keys = tls_private_key.key.public_key_openssh
  }

  preserve_boot_volume = false

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "opc"
    private_key = tls_private_key.key.private_key_openssh
  }

  provisioner "remote-exec" {
    inline = [
      "docker run --name api -d -p 80:8080 ${var.docker_image}:${var.docker_api_version}",
    ]
  }
}

resource "oci_core_instance" "web_2" {
  #Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id      = var.compartment_id
  shape               = var.vm_config.shape

  display_name = "web-2"

  create_vnic_details {
    #Optional
    assign_public_ip = true
    subnet_id        = oci_core_subnet.public_2.id
  }

  shape_config {
    #Optional
    memory_in_gbs = var.vm_config.memory
    ocpus         = var.vm_config.ocpu
  }
  source_details {
    #Required
    source_id   = var.ami_ocid
    source_type = "image"

  }
  #ssh key
  metadata = {
    ssh_authorized_keys = tls_private_key.key.public_key_openssh
  }

  preserve_boot_volume = false

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "opc"
    private_key = tls_private_key.key.private_key_openssh
  }

  provisioner "remote-exec" {
    inline = [
      "docker run --name api -d -p 80:8080  ${var.docker_image}:${var.docker_api_version}",
    ]
  }
}