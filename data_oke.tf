data "oci_containerengine_cluster_kube_config" "this" {
  cluster_id = var.oke_cluster_id
}

locals {
  kubeconfig_yaml = data.oci_containerengine_cluster_kube_config.this.content
  kubeconfig      = yamldecode(local.kubeconfig_yaml)

  cluster_entry = local.kubeconfig.clusters[0].cluster

  host                   = local.cluster_entry.server
  cluster_ca_certificate = base64decode(local.cluster_entry["certificate-authority-data"])
}
