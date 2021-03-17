variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
variable "compartment_ocid" {}
variable "region" {}


variable "VCNname" {
  default = "BSVCN"
}

variable "ocir_namespace" {
  default = ""
}

variable "ocir_repo_name" {
  default = ""
}

variable "ocir_docker_repository" {
  default = ""
}

variable "ocir_user_name" {
  default = ""
}

variable "ocir_user_password" {
  default = ""
}

variable "application_config" {
  default = {"fail_limit":"2"}
}

variable "gateway_endpoint_type" {
  default = "PUBLIC"
}
	
variable "deployment_path_prefix" {
  default = "/nvahc"
}