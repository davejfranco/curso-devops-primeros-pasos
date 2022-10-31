data "oci_identity_availability_domains" "ads" {
  #Required
  compartment_id = var.compartment_id
}
