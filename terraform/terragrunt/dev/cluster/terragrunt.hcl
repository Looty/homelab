include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_terragrunt_dir()}../../../..//modules/cluster"
}

locals {
  env = reverse(split("/", get_terragrunt_dir()))[1] # = dev
}

inputs = {
  cluster_name        = local.env
  master_nodes_amount = 1
  worker_nodes_amount = 2
}