# App: Argo CD
# Version: 2.6.7+5bcd846
resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.27.2"
  cleanup_on_fail  = true
  create_namespace = true
  max_history      = 3
}
