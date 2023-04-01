resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = var.chartPath
  namespace        = "argocd"
  cleanup_on_fail  = true
  create_namespace = true
}

resource "kubectl_manifest" "addons" {
  yaml_body = file(var.applicationSetPath)

  depends_on = [
    helm_release.argocd
  ]
}
