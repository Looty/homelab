variable "cluster_name" {
  type        = string
  description = "K3d cluster name"
}

variable "node_image" {
  type        = string
  description = "K3d node image"
  default     = "rancher/k3s:v1.24.4-k3s1"
}

variable "host_port" {
  type        = number
  description = "Kubernetes host port"
  default     = 6445
}

variable "host_ip" {
  type        = string
  description = "Kubernetes API will be listening on"
  default     = "127.0.0.1"
}

variable "master_nodes_amount" {
  type        = number
  description = "Amount of master nodes"
}

variable "worker_nodes_amount" {
  type        = number
  description = "Amount of worker nodes"
}
