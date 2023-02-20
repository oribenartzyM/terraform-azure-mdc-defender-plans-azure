data "azurerm_subscriptions" "available" {}

locals {
  list_of_subscriptions = data.azurerm_subscriptions.available.subscriptions[*].subscription_id
}