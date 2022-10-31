module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.5.2"

  compartment_id = var.compartment_id
  vcn_name       = var.vcn_name
  vcn_cidrs      = ["10.0.0.0/16"]

  create_internet_gateway       = true
  internet_gateway_display_name = var.igw_name

}

#Security List
resource "oci_core_security_list" "ssh" {
  compartment_id = var.compartment_id
  display_name   = "${var.label_prefix}-ssh"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    # allow ssh
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }
  vcn_id = module.vcn.vcn_id
}

resource "oci_core_security_list" "web" {
  compartment_id = var.compartment_id
  display_name   = "${var.label_prefix}-web"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    # allow http
    protocol = 6
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }
  vcn_id = module.vcn.vcn_id
}

resource "oci_core_subnet" "public_1" {
  cidr_block                 = "10.0.20.0/24"
  compartment_id             = var.compartment_id
  display_name               = "${var.label_prefix}-public-1"
  dns_label                  = "public1"
  prohibit_public_ip_on_vnic = false
  route_table_id             = module.vcn.ig_route_id
  security_list_ids          = [oci_core_security_list.web.id, oci_core_security_list.ssh.id]
  vcn_id                     = module.vcn.vcn_id
}

resource "oci_core_subnet" "public_2" {
  cidr_block                 = "10.0.30.0/24"
  compartment_id             = var.compartment_id
  display_name               = "${var.label_prefix}-public-2"
  dns_label                  = "public2"
  prohibit_public_ip_on_vnic = false
  route_table_id             = module.vcn.ig_route_id
  security_list_ids          = [oci_core_security_list.web.id, oci_core_security_list.ssh.id]
  vcn_id                     = module.vcn.vcn_id
}