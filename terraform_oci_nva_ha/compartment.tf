resource "oci_identity_compartment" "BSCompartment" {
  name = "BSCompartment"
  description = "BS Compartment"
  compartment_id = var.compartment_ocid
}

