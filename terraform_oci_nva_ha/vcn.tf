resource "oci_core_virtual_network" "BSVCN" {
  cidr_block = "192.168.168.0/24"
  dns_label = "nvaha"
  compartment_id = oci_identity_compartment.BSCompartment.id
  display_name = "NVA_HA-CVN"
}

# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

# Gets the Id of a specific OS Images
data "oci_core_images" "OSImageLocal" {
  compartment_id = var.compartment_ocid
  display_name   = var.OsImage
}
