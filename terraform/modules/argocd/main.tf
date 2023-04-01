resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = var.chartPath
  namespace        = "argocd"
  cleanup_on_fail  = true
  create_namespace = true
}

resource "kubectl_manifest" "addons" {
  yaml_body = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: addons
  namespace: argocd
spec:
  generators:
  - list:
      elements:
      - addon: ingress-nginx
        namespace: ingress-nginx
      - addon: metallb
        namespace: metallb-system
  template:
    metadata:
      name: '{{addon}}'
    spec:
      project: default
      source:
        repoURL: https://github.com/Looty/homelab.git
        targetRevision: HEAD
        path: 'manifests/addons/{{addon}}'
      destination:
        server: https://kubernetes.default.svc
        namespace: '{{namespace}}'
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
