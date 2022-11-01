output "key-private-pem" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}

output "web1_public_ip" {
  value = oci_core_instance.web_1.public_ip
}

output "web2_public_ip" {
  value = oci_core_instance.web_2.public_ip
}