terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "4.96.0"
    }
  }
}

provider "oci" {
  region = var.region
}

provider "tls" {}