resource "oci_core_internet_gateway" "BSInternetGateway" {
    compartment_id = oci_identity_compartment.BSCompartment.id
    display_name = "BSInternetGateway"
    vcn_id = oci_core_virtual_network.BSVCN.id
}
