provider "kubernetes" {
  config_path    = local_file.kubeconfig.filename # TODO vars
  # config_context = "do-ams3-buzzword-stack-kubernetes-cluster" # TODO ??
}

data "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
  # depends_on = [ kubernetes_secret.dockerconfig ] # ?????
}

resource "kubernetes_secret" "dockerconfig" {
  metadata {
    name = "regcred"
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.docker-credentials.docker_credentials # TODO vars
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_secret" "database-uri" {
  metadata {
    name = "database-connection"
  }
  data = {
    "dbname"  = digitalocean_database_db.database.name, # TODO vars
    "dbuser" = digitalocean_database_user.db-user.name, # TODO vars
    "dbpass" = digitalocean_database_user.db-user.password, # TODO vars
    "dbhost" = digitalocean_database_cluster.postgres-cluster.private_host, # TODO vars
    "dbport" = digitalocean_database_cluster.postgres-cluster.port # TODO vars
  }
}
