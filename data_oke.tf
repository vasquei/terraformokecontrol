data "oci_containerengine_cluster_kube_config" "this" {
  cluster_id = var.oke_cluster_id
}

locals {
  kubeconfig_yaml = data.oci_containerengine_cluster_kube_config.this.content
  kubeconfig      = yamldecode(local.kubeconfig_yaml)

  # Toma el primer cluster/context del kubeconfig generado por OCI
  cluster_entry = local.kubeconfig.clusters[0].cluster

  host                   = local.cluster_entry.server
  cluster_ca_certificate = base64decode(local.cluster_entry["certificate-authority-data"])
}

# Kubernetes provider usando token generado por OCI
# (OCI provider puede generar un token de autenticación para OKE)
provider "kubernetes" {
  host                   = local.host
  cluster_ca_certificate = local.cluster_ca_certificate
  token                  = data.oci_containerengine_cluster_kube_config.this.token
}
