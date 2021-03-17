resource "oci_core_internet_gateway" "BSInternetGateway" {
    compartment_id  = var.compartment_ocid
    display_name = "BSInternetGateway"
    vcn_id = oci_core_virtual_network.BSVCN.id
}
