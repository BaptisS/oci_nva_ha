resource "null_resource" "BSFnSetup" {
  depends_on = [oci_functions_application.BSFnApp]

  provisioner "local-exec" {
    command = "echo '${var.ocir_user_password}' |  docker login ${var.ocir_docker_repository} --username ${var.ocir_namespace}/${var.ocir_user_name} --password-stdin"
  }

  provisioner "local-exec" {
    command = "fn build"
    working_dir = "functions/oci_nva_ha"
  }

  provisioner "local-exec" {
    command = "image=$(docker images | grep nva_ha | awk -F ' ' '{print $3}') ; docker tag $image ${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/nva_ha:0.0.1"
    working_dir = "functions/oci_nva_ha"
  }

  provisioner "local-exec" {
    command = "docker push ${var.ocir_docker_repository}/${var.ocir_namespace}/${var.ocir_repo_name}/nva_ha:0.0.1"
    working_dir = "functions/oci_nva_ha"
  }


}
