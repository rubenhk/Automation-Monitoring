###########################################################################################################
# PROVIDERS & VERSIONS
###########################################################################################################

terraform {
  required_version = ">= 0.13.2"

  backend "azurerm" {}
}

provider "azurerm" {
  version = ">= 2.41.0"
  features {}
  use_msi         = true
  subscription_id = var.subscription_id
}

provider "azurerm" {
  version         = ">= 2.51.0"
  subscription_id = var.vpe_subid
  alias           = "vpe"
  features {}
}
