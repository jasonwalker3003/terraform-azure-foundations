data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "lab" {
  name     = "rg-tf-w05"
  location = "uksouth"

  tags = {
    env   = "lab"
    owner = "jason"
    week  = "05"
    subscription = data.azurerm_subscription.current.display_name
  }
}
