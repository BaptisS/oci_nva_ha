resource "oci_core_network_security_group" "BSSSHSecurityGroup" {
    compartment_id  = var.compartment_ocid
    display_name = "BSSSHSecurityGroup"
    vcn_id = oci_core_virtual_network.BSVCN.id
}

