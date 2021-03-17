resource "oci_functions_application" "BSFnApp" {
    compartment_id = oci_identity_compartment.BSCompartment.id
    display_name = "nva_ha"
    subnet_ids = [oci_core_subnet.BSPublicSubnet.id]
}

resource "oci_functions_function" "BSnva_ha" {
    depends_on = [null_resource.BSFnSetup]
    application_id = oci_functions_application.BSFnApp.id
    display_name = "nva_ha"
    image = "${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/nva_ha:0.0.1"
    memory_in_mbs = "256" 
}

