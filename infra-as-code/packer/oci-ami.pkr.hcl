packer {
  required_plugins {
    oracle = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/oracle"
    }
  }
}

source "oracle-oci" "fastapi" {
  availability_domain = "${var.ad}"
  compartment_ocid    = "${var.compartment_ocid}"
  image_name          = "${var.ami_name}"
  ssh_username        = "${var.ssh_username}"
  subnet_ocid         = "${var.subnet_ocid}"
  base_image_ocid     = "${var.base_image_ocid}"
  shape               = "${var.vm_builder.shape}"
  shape_config {
    ocpus         = "${var.vm_builder.ocpu}"
    memory_in_gbs = "${var.vm_builder.memory}"
  }
}

build {
  sources = ["source.oracle-oci.fastapi"]

  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y dnf-utils zip unzip",
      "sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo dnf remove -y runc",
      "sudo dnf install -y docker-ce --nobest",
      "sudo systemctl enable docker.service",
      "sudo systemctl start docker.service",
      "sudo usermod -aG docker ${var.ssh_username}"
    ]
  }
}

