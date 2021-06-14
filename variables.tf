###########################################################################################################
# PROVIDERS
###########################################################################################################

# ID of the Azure Subscription this configuration is targeted against
variable "subscription_id" {
  #default = "b970f71b-bc04-47c8-89cd-7e491b4656b2"
}

# ID of the Service principal used to access the target Azure Subscription
variable "client_id" {
  default = null
}

# Secret value of the Service principal used to access the target Azure Subscription
variable "client_secret" {
  default = ""
}

# ID of the Azure AD tenant used for authenticating to the target Azure Subscription
variable "tenant_id" {
  default = "fa07c4aa-54b4-4654-a33e-3209f4138cab"
}

###########################################################################################################
# RESOURCES
###########################################################################################################

# Name of the monitoring resource group
variable "resource_group_name" {
  type = string
}

# Location of the monitoring resource group
variable "location" {
  type = string
}

# Log Analytics Workspace Name
variable "laws_name" {
  type = string
}

# Log Analytics Tags
variable "laws_tags" {
  type = map(string)
}

/*
# Event Hub Namespace Name
variable "eventhub_namespace" {
  type = string
}

# Event Hub Name
variable "eventhub_name" {
  type = string
}

# Event Hub Tags
variable "eventhub_tags" {
  type = map(string)
}
*/

# Group to assign Monitoring Contributor to - to allow Azure Policy Assignment (deployIfNotExist)
variable "pa_msi_group_object_id" {
  type = string
}

# Group to assign Reader to allow provider to connect
variable "dev_pipeline_group_object_id" {
  type    = string
  default = null
}


variable "AutomationAccount_name" {
  type = string
}

variable "retention_in_days" {
  default = "31"
}

variable "ResNamePrefix" {
  type        = string
  description = "Prefix of resource name. This prefix will be added to all the name of resources"
}

variable "network_rules" {
  description = "Network rules restricing access to the storage account."
  type        = object({ ip_rules = list(string), subnet_ids = list(string), bypass = list(string), default_action = string })
  default = {
    default_action = "Deny"
    ip_rules       = null
    subnet_ids     = null
    bypass         = ["AzureServices"]

  }
}

variable "vpe_subid" {
  type    = string
  default = "91887bea-0e35-41b8-aae4-5ba987c3c1e8"
}

variable "vpe_rgname" {
  type = string
}

variable "vpe_vnetname" {
  type = string
}

variable "pe_subnet" {
  type        = string
  description = "The name of the subnet to create the Private Endpoints for ancillary resources (Storage Account and KeyVault)"
}
