# Terraform Cloud Integration with Oracle Cloud Infrastructure (OCI) and Oracle Kubernetes Engine (OKE)

## Introduction

This repository demonstrates how to integrate **Terraform Cloud** with **Oracle Cloud Infrastructure (OCI)** to manage Kubernetes resources inside an existing **Oracle Kubernetes Engine (OKE)** cluster.

The goal of this project is to provision Kubernetes objects (a namespace and an Nginx deployment) from Terraform Cloud using secure, dynamic authentication without relying on a static kubeconfig file.

---

## Documentation / Background

Terraform Cloud supports two execution models:

- Hosted Runners (managed by HashiCorp)
- Terraform Cloud Agents (self-hosted)

When working with OCI and OKE, Kubernetes authentication requires generating a temporary token using the OCI CLI. Because hosted runners do not include OCI CLI, this project adopts a Terraform Cloud Agent running inside OCI.

---

## Main Points

### Terraform Connection to OCI

Terraform OCI provider supports two ways to supply private keys:

- `private_key` → Expects the PEM content of the private key as a string  
- `private_key_path` → Expects the file path to the private key  

For this project:

- `private_key` is used
- The private key is stored as a **sensitive variable** in Terraform Cloud

  <img width="1249" height="82" alt="private_key" src="images/private_key.png" />





Benefits:

- No private key files stored on disk
- Credentials remain encrypted
- Easier automation

---

### Dynamic Retrieval of OKE Cluster Certificate

Terraform retrieves OKE cluster information using:

```hcl
data "oci_containerengine_cluster_kube_config" "oke" {
  cluster_id = var.cluster_id
}

