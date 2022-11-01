resource "oci_load_balancer" "lb" {
  compartment_id = var.compartment_id
  display_name   = "${var.label_prefix}-lb"
  ip_mode    = "IPV4"
  is_private = "false"
  shape = "flexible"
  shape_details {
    #Required
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
  subnet_ids = [
    oci_core_subnet.public_1.id
  ]
}

resource "oci_load_balancer_backend_set" "lb_set" {
  health_checker {
    interval_ms       = "5000"
    port              = "80"
    protocol          = "HTTP"
    retries           = "3"
    return_code       = "200"
    timeout_in_millis = "3000"
    url_path          = "/"
  }

  load_balancer_id = oci_load_balancer.lb.id
  name             = "${var.label_prefix}-lb-set"
  policy           = "WEIGHTED_ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "web_1" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.lb_set.name
  ip_address       = oci_core_instance.web_1.public_ip
  load_balancer_id = oci_load_balancer.lb.id
  port             = 80
}

# resource "oci_load_balancer_backend" "web_2" {
#   #Required
#   backendset_name  = oci_load_balancer_backend_set.lb_set.name
#   ip_address       = oci_core_instance.web_2.public_ip
#   load_balancer_id = oci_load_balancer_load_balancer.lb.id
#   port             = 80
# }

resource "oci_load_balancer_listener" "lb_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.lb_set.name
  load_balancer_id         = oci_load_balancer.lb.id
  name                     = "${var.label_prefix}-http-listener"
  port                     = "80"
  protocol                 = "HTTP"
}