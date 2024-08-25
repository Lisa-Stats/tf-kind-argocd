terraform {
  required_version = ">= 1.6.0"
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.5.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.14.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "kind" {}

provider "helm" {
  kubernetes {
    host = kind_cluster.default.endpoint
    cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
    client_certificate = kind_cluster.default.client_certificate
    client_key = kind_cluster.default.client_key
  }
}

provider "kubernetes" {
  host = kind_cluster.default.endpoint
  client_certificate = kind_cluster.default.client_certificate
  client_key = kind_cluster.default.client_key
  cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
}
