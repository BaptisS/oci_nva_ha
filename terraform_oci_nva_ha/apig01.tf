resource "oci_apigateway_gateway" "BSapig01" {
    #Required
    compartment_id        = var.compartment_ocid
    endpoint_type         = var.gateway_endpoint_type
    #subnet_id             = oci_core_subnet.apig[0].id
	subnet_id             = oci_core_subnet.BSPublicSubnet.id

    #Optional
    #ertificate_id = "${oci_apigateway_certificate.test_certificate.id}"
    #defined_tags = {"Operations.CostCenter"= "42"}
    display_name = "apig01"
    #freeform_tags = {"Department"= "Finance"}
}

resource "oci_apigateway_deployment" "BSapiDeployment01" {
    #Required
    compartment_id = var.compartment_ocid
    gateway_id = oci_apigateway_gateway.BSapig01.id
    path_prefix = var.deployment_path_prefix
    specification {
      
        routes {
            #Required
            backend {
                #Required
                type = "ORACLE_FUNCTIONS_BACKEND"
                #Optional
                function_id = oci_functions_function.BSnva_ha.id               
            }
            path = "/hc/" 
            methods = ["GET"]
        }
    }

    #Optional
    #defined_tags = {"Operations.CostCenter"= "42"}
    #display_name = "nva_ha"
    #freeform_tags = {"Department"= "Finance"}
}
    