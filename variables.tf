variable "tenancy_ocid" { type = string }
variable "user_ocid" { type = string }
variable "fingerprint" { type = string }
variable "private_key" { type = string }
variable "region" { type = string }

variable "compartment_ocid" { type = string }
variable "oke_cluster_id" { type = string }

# opcional: para Namespace de ejemplo
variable "namespace_name" {
  type    = string
  default = "apps"
}
