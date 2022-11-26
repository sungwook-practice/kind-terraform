resource "helm_release" "argocd" {
  # reference: https://github.com/hashicorp/terraform-provider-helm/issues/400#issuecomment-583561090
  provider = helm.cluster-1
  name     = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.14.2"
  create_namespace = true

  values = [
    file("helm/argocd/values.yaml")
  ]
}