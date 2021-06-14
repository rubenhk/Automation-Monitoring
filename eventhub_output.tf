output "namespace_id" {
  description = "Output the object ID"
  value       = azurerm_eventhub_namespace.eventhub_namespace.id
}

output "namespace_name" {
  description = "Output the object name"
  value       = azurerm_eventhub_namespace.eventhub_namespace.name
}

output "namespace_object" {
  sensitive   = true
  description = "Output the full object"
  value       = azurerm_eventhub_namespace.eventhub_namespace
}

output "eventhub_id" {
  description = "Output the object ID"
  value       = azurerm_eventhub.eventhub.id
}

output "eventhub_name" {
  description = "Output the object name"
  value       = azurerm_eventhub.eventhub.name
}

output "eventhub_object" {
  sensitive   = true
  description = "Output the full object"
  value       = azurerm_eventhub.eventhub
}
