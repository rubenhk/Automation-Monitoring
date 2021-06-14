locals {

  storageaccounts = {
    neu = {
      name     = "${substr(replace(var.ResNamePrefix, "-", ""), 2, 11)}${random_string.unique.result}neusa01"
      location = "northeurope"
    }
  }

}

resource "random_string" "unique" {
  length  = 1
  special = false
  upper   = false
  number  = false
}


module "storageaccount" {
  for_each = local.storageaccounts

  source              = "git::https://KulaKeepUK:PATTOKEN1@dev.azure.com/KulaKeepUK/CloudServices/_git/hsbc-terraform-azurerm-storageaccount-private-endpoint?ref=main"
  sa_name             = each.value.name
  resource_group_name = azurerm_resource_group.monitoring.name
  location            = each.value.location
  network_rules       = var.network_rules

  containers_required = false
}

resource "azurerm_private_endpoint" "storageaccount_blob_pe" {
  for_each = local.storageaccounts

  provider            = azurerm.vpe
  name                = "${each.value.name}-blob-private-endpoint"
  resource_group_name = data.azurerm_virtual_network.vpe.resource_group_name
  location            = data.azurerm_virtual_network.vpe.location
  subnet_id           = "${data.azurerm_virtual_network.vpe.id}/subnets/${var.pe_subnet}"
  private_service_connection {
    name                           = "vpeblobsubendpoint"
    private_connection_resource_id = module.storageaccount[each.key].sa_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, tags are updated and set based on azure policy 
      tags,
      # Ignore changes to private_dns_zone_group - as DNS record(s) are deployed by azure policy
      private_dns_zone_group
    ]
  }
}
