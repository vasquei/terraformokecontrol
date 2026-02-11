provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key = var.private_key
  region           = var.region
}

provider "kubernetes" {
  host                   = local.host
  cluster_ca_certificate = local.cluster_ca_certificate

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "oci"
    args = [
      "ce",
      "cluster",
      "generate-token",
      "--cluster-id",
      var.oke_cluster_id,
      "--region",
      var.region
    ]
  }
}

