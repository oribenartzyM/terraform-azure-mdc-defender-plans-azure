data "azurerm_management_group" "mgroup" {
    name = "policy-testing" # This is the ID of the management group
}

locals {
  list_of_subscriptions = data.azurerm_management_group.mgroup.subscription_ids
}