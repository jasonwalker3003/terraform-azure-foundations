locals {
  tags = {
    env   = "lab"
    owner = "jason"
    week  = "05"
  }
}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "lab" {
  name     = "rg-${var.prefix}"
  location = var.location
  tags     = merge(local.tags, { subscription = data.azurerm_subscription.current.display_name })
}
