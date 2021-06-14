resource "azurerm_automation_account" "AutomationAccount1" {
  name                = var.AutomationAccount_name
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name

  sku_name = "Basic"

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, tags are updated and set based on azure polocy 
      tags
    ]
  }
}

## Link the automation account to Law workspace for change tracing and inventory management - https://docs.microsoft.com/en-us/azure/automation/change-tracking/enable-from-vm

resource "azurerm_log_analytics_linked_service" "AutomationAccount1_lawslink" {
  resource_group_name = azurerm_resource_group.monitoring.name
  workspace_id        = module.loganalytics.id
  read_access_id      = azurerm_automation_account.AutomationAccount1.id
}
