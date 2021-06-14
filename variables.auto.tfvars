subscription_id     = "aa56c7fd-ba40-4a3d-a552-8d5929234f6b"
ResNamePrefix       = "kk-mgt-mon-prd"
resource_group_name = "kk-mgt-mon-prd-neu-rg-01"
location            = "northeurope"
laws_name           = "kk-mgt-mon-prd-neu-law-01"
laws_tags = {
  environment = "Production"
}
/*
eventhub_namespace = "kk-mgt-mon-prd-neu-aeh-01"
eventhub_name      = "kk-mgt-mon-prd-neu-aeh-01"
eventhub_tags = {
  environment = "Production"
}
*/
pa_msi_group_object_id = "515eb646-b3a3-478a-9f2c-6a9b34aff11b" # AAD Group: acst-devops-policy-assignments-msi-prod-ADRoles

AutomationAccount_name = "kk-mgt-mon-prd-neu-aa-01"

retention_in_days = 730

network_rules = {
  default_action = "Deny"
  ip_rules       = ["91.214.4.0/22", "193.108.72.0/21", "52.142.127.252", "20.54.127.28"]
  subnet_ids     = null
  bypass         = ["AzureServices"]

}

vpe_subid    = "cdbde38c-ae88-4c33-9601-bc1c9ae1ba18"
vpe_rgname   = "kk-com-vpe-prd-neu-net-rg-01"
vpe_vnetname = "kk-com-vpe-prd-neu-vnet-01"
pe_subnet    = "mgtpe"
