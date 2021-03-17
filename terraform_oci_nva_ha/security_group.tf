resource "oci_core_network_security_group" "BSSSHSecurityGroup" {
    compartment_id = oci_identity_compartment.BSCompartment.id
    display_name = "BSSSHSecurityGroup"
    vcn_id = oci_core_virtual_network.BSVCN.id
}

