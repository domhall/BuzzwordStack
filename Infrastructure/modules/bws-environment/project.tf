resource "digitalocean_project" "buzzword_stack" {
  name        = "{var.project_name}-${var.env_name}-project"
  description = "A project with a lot of technologies."
  purpose     = "Web Application"
  environment = "${var.env_name}"
}

resource "digitalocean_project_resources" "resources" {
  project = digitalocean_project.buzzword_stack.id
  resources = [
    digitalocean_database_cluster.postgres_cluster.urn,
    "do:kubernetes:${digitalocean_kubernetes_cluster.cluster.id}",
  ]
}