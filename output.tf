output "loganalytics_id" {
  value = module.loganalytics.id
}


output "loganalytics_workspace_id" {
  value = module.loganalytics.object.workspace_id
}

output "automationaccount_id" {
  value = azurerm_automation_account.AutomationAccount1.id
}

output "resource_group_name" {
  value = azurerm_resource_group.monitoring.name
}

output "resource_group_location" {
  value = azurerm_resource_group.monitoring.location
}

/*
output "eventhub_id" {
  description = "Output the object ID"
  value       = module.eventhub.eventhub_id
}

output "eventhub_name" {
  description = "Output the object name"
  value       = module.eventhub.eventhub_name
}
*/
