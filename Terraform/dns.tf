resource "azurerm_dns_txt_record" "asuid" {
  name                = "asuid"
  resource_group_name = var.dns_zone_resource_group_name
  zone_name           = var.dns_zone_name
  ttl                 = 300

  record {
    value = azurerm_container_app.container_app.custom_domain_verification_id
  }
}

resource "null_resource" "wait_for_container_app" {
  triggers = {
    fqdn = azurerm_container_app.container_app.latest_revision_fqdn
  }
}

resource "azurerm_dns_cname_record" "cname" {
  depends_on          = [null_resource.wait_for_container_app]
  name                = "@"
  resource_group_name = var.dns_zone_resource_group_name
  zone_name           = var.dns_zone_name
  ttl                 = 300
  record              = null_resource.wait_for_container_app.triggers.fqdn
}

resource "azurerm_container_app_custom_domain" "cacd" {
  depends_on       = [azurerm_dns_txt_record.asuid, azurerm_dns_cname_record.cname]
  name             = var.dns_zone_name
  container_app_id = azurerm_container_app.container_app.id


  lifecycle {
    ignore_changes = [
      certificate_binding_type,
      container_app_environment_certificate_id
    ]
  }
}