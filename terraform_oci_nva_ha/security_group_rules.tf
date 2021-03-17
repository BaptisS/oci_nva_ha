resource "oci_core_network_security_group_security_rule" "BSSSHSecurityEgressGroupRule" {
    network_security_group_id = oci_core_network_security_group.BSSSHSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "BSSSHSecurityIngressGroupRules" {
    for_each = toset(var.https_ports)

    network_security_group_id = oci_core_network_security_group.BSSSHSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = each.value
            min = each.value
        }
    }
}
