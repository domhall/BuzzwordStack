resource "digitalocean_database_db" "database" {
  cluster_id = digitalocean_database_cluster.postgres-cluster.id
  name       = var.dbname
}

resource "digitalocean_database_cluster" "postgres-cluster" {
  name       = "${var.project_name}-${var.env_name}-database-cluster"
  engine     = "pg"
  version    = "11"
  size       = "db-s-1vcpu-1gb" # TODO Vars
  region     = "ams3"
  node_count = 1
}

resource "digitalocean_database_user" "db_user" {
  cluster_id = digitalocean_database_cluster.postgres-cluster.id
  name       = var.dbuser
}

resource "digitalocean_database_firewall" "db_firewall" {
  cluster_id = digitalocean_database_cluster.postgres-cluster.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.cluster.id
  }
}
