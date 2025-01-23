resource "azurerm_container_app" "container_app" {
  name                         = local.container_app_name
  resource_group_name          = local.container_app_resource_group_name
  container_app_environment_id = local.container_app_environment_id
  revision_mode                = "Single"
  
  secret {
    name  = "registry-password"
    value = var.github_token
  }

  ingress {
    external_enabled = true

    traffic_weight {
      latest_revision = true
      percentage = 100
    }
    
    target_port = 80
  }

  template {
    max_replicas = var.max_replicas
    min_replicas = var.min_replicas
    revision_suffix = var.sha

    container {
      name   = "${local.container_app_name}-cont"
      image  = local.container_app_image
      memory = var.memory
      cpu    = var.cpu
    }
  }

  registry {
    server = var.registry_server
    username = var.registry_username
    password_secret_name = "registry-password"
  }
}
