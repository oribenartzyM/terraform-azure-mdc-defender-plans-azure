data "azurerm_subscriptions" "available" {}

locals {
  list_of_subscriptions = ["d533b51a-489e-4113-a2d1-2fa3b6ecc02e", "b78981a4-9b73-4ec0-9c3e-243bb06d6ae4", "3654c3db-3529-48e0-9473-5719d3dcfe7d"]
}