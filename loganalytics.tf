module "loganalytics" {
  source            = "../modules/loganalytics"
  rg_name           = azurerm_resource_group.monitoring.name
  location          = azurerm_resource_group.monitoring.location
  retention_in_days = var.retention_in_days
  laws_name         = var.laws_name
  tags              = var.laws_tags
}
