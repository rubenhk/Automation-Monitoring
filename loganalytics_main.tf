data "azurerm_subscription" "current" {
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.laws_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku
  tags                = var.tags
  retention_in_days   = var.retention_in_days != "" ? var.retention_in_days : null

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, tags are updated and set based on azure polocy 
      tags
    ]
  }

}
