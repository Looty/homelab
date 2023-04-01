resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = var.chartPath
  namespace        = "argocd"
  cleanup_on_fail  = true
  create_namespace = true
}
