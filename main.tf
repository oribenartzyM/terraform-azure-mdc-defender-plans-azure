resource "azurerm_security_center_subscription_pricing" "asc_plans" {
  count = length(var.mdc_plans_list)

  tier          = var.tier
  resource_type = var.mdc_plans_list[count.index]
  subplan       = var.subplan
}