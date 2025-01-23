resource "azurerm_dns_txt_record" "asuid" {
  name = "asuid.${var.dns_zone_name}"
  resource_group_name = var.dns_zone_resource_group_name
  zone_name = var.dns_zone_name
  ttl = 300

  record {
    value = azurerm_container_app.container_app.custom_domain_verification_id
  }
}

resource "azurerm_container_app_custom_domain" "cacd" {
  name = var.dns_zone_name
  container_app_id = azurerm_container_app.container_app.id

  lifecycle {
    ignore_changes = [ 
        certificate_binding_type,
        container_app_environment_certificate_id
    ]
  }
}