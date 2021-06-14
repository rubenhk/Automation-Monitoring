# This is EventHub file folder in Automation Monitoring folder

data "azurerm_subscription" "current" {
}

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = var.eventhub_namespace
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku
  capacity            = var.capacity
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, tags are updated and set based on azure polocy 
      tags
    ]
  }
}

resource "azurerm_eventhub" "eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = var.rg_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}
