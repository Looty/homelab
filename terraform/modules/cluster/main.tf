resource "k3d_cluster" "cluster" {
  name    = var.cluster_name
  image   = var.node_image
  servers = var.master_nodes_amount
  agents  = var.worker_nodes_amount

  kube_api {
    host_ip   = var.host_ip
    host_port = var.host_port
  }

  port {
    host_port      = 8080
    container_port = 80
    node_filters = [
      "loadbalancer",
    ]
  }

  k3s {
    extra_args {
      arg = "--disable=traefik"
      node_filters = [
        "server:0",
      ]
    }
  }

  # k3d {
  #   disable_load_balancer = false
  #   disable_image_volume  = false
  # }

  kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = true
  }
}
