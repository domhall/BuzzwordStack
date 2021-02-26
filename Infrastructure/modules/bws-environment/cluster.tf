
resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "${var.project_name}-${var.env_name}-kubernetes-cluster"
  region  = "ams3"
  version = "1.20.2-do.0"
  node_pool {
    name       = "${var.project_name}-${var.env_name}-cluster-base-pool"
    size       = "s-2vcpu-2gb" # TODO vars
    node_count = 1
  }
}

resource "digitalocean_kubernetes_node_pool" "scaling_pool" {
  cluster_id = digitalocean_kubernetes_cluster.cluster.id
  name       = "${var.project_name}-${var.env_name}-cluster-pool"
  size       = "s-1vcpu-2gb" # TODO vars
  auto_scale = true
  min_nodes  = 1 # TODO vars
  max_nodes  = 9
}
