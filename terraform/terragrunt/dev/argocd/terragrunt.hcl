include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_terragrunt_dir()}../../../..//modules/argocd"
}

locals {
  env       = reverse(split("/", get_terragrunt_dir()))[1] # = dev
  chartPath = "${get_terragrunt_dir()}/../../../../manifests/argo-cd"
}

dependency "cluster" {
  config_path = "../cluster"
}

inputs = {
  host                   = dependency.cluster.outputs.host
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
  client_certificate     = dependency.cluster.outputs.client_certificate
  client_key             = dependency.cluster.outputs.client_key

  chartPath = local.chartPath
}