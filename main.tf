###########################################################################################################
# LOCALS
###########################################################################################################
###########################################################################################################
# RESOURCE GROUP & IAM
###########################################################################################################

# Retrieve data from current subscription
data "azurerm_subscription" "current" {}

data "azurerm_virtual_network" "vpe" {
  provider            = azurerm.vpe
  resource_group_name = var.vpe_rgname
  name                = var.vpe_vnetname
}

# Reference to Resource group
resource "azurerm_resource_group" "monitoring" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_role_assignment" "loganalytics" {
  scope                = azurerm_resource_group.monitoring.id
  role_definition_name = "Monitoring Contributor"
  principal_id         = var.pa_msi_group_object_id
}

resource "azurerm_role_assignment" "loganalytics_dev_pipeline" {
  count                = var.dev_pipeline_group_object_id == null ? 0 : 1
  scope                = azurerm_resource_group.monitoring.id
  role_definition_name = "Reader"
  principal_id         = var.dev_pipeline_group_object_id
}

resource "azurerm_role_assignment" "loganalytics_contributor" {
  scope                = azurerm_resource_group.monitoring.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = var.pa_msi_group_object_id
}
