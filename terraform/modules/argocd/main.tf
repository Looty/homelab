resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = var.chartPath
  namespace        = "argocd"
  cleanup_on_fail  = true
  create_namespace = true
}

resource "kubectl_manifest" "metallb" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: metallb
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/Looty/homelab.git
    targetRevision: HEAD
    path: manifests/charts/metallb
  destination:
    server: https://kubernetes.default.svc
    namespace: metallb-system
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
YAML

  depends_on = [
    helm_release.argocd
  ]
}
