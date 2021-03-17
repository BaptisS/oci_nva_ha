resource "oci_core_dhcp_options" "BSDhcpOptions1" {
  compartment_id = oci_identity_compartment.BSCompartment.id
  vcn_id = oci_core_virtual_network.BSVCN.id
  display_name = "BSDHCPOptions1"

  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type = "SearchDomain"
    search_domain_names = [ "bs.com" ]
  }
}
