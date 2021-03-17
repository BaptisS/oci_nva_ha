resource "oci_core_subnet" "BSPublicSubnet" {
  cidr_block = "192.168.168.0/27"
  display_name = "DMZ-SN"
  dns_label = "dmz"
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_virtual_network.BSVCN.id
  route_table_id = oci_core_route_table.BSRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.BSDhcpOptions1.id
}


