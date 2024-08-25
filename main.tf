resource "kind_cluster" "default" {
  name = "kind-cluster"
  wait_for_ready = true
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }

  depends_on = [kind_cluster.default]
}

resource "helm_release" "argocd_helm" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.4.2"

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "dex.enabled"
    value = false
  }

  set {
    name  = "notifications.enabled"
    value = false
  }

  depends_on = [kubernetes_namespace.argocd]
}
