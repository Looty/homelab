output "host" {
  value     = k3d_cluster.cluster.credentials[0].host
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = replace(k3d_cluster.cluster.credentials[0].cluster_ca_certificate, "\n", "")
  sensitive = true
}

output "client_certificate" {
  value     = replace(k3d_cluster.cluster.credentials[0].client_certificate, "\n", "")
  sensitive = true
}

output "client_key" {
  value     = replace(k3d_cluster.cluster.credentials[0].client_key, "\n", "")
  sensitive = true
}
