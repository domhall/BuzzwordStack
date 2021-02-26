resource "digitalocean_container_registry" "container_registry" {
  name                   = "${var.project_name}-container-registry"
  subscription_tier_slug = "basic"
}

# data "digitalocean_container_registry" "container-registry" { ?????????
#   name = digitalocean_container_registry.container-registry.name
# }

resource "digitalocean_container_registry_docker_credentials" "docker_credentials" {
  write = true # TODO write = true?
  registry_name = digitalocean_container_registry.container_registry.name
}