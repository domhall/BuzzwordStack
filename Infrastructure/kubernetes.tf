provider "kubernetes" {
  config_path    = local_file.kubeconfig.filename
  config_context = "do-ams3-buzzword-stack-kubernetes-cluster"
}

data "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
  depends_on = [ kubernetes_secret.dockerconfig ]
}

resource "kubernetes_secret" "dockerconfig" {
  metadata {
    name = "regcred"
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.docker-credentials.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_secret" "database-uri" {
  metadata {
    name = "database-connection"
  }
  data = {
    "dbname"  = digitalocean_database_db.database.name,
    "dbuser" = digitalocean_database_user.db-user.name,
    "dbpass" = digitalocean_database_user.db-user.password,
    "dbhost" = digitalocean_database_cluster.postgres-cluster.private_host,
    "dbport" = digitalocean_database_cluster.postgres-cluster.port
  }
}
