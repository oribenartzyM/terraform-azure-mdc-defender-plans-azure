resource "azurerm_security_center_subscription_pricing" "asc_plans" {
  for_each = var.mdc_plans_list
  #checkov:skip=CKV_AZURE_19:The actual tier will be known after we've got a tfplan
  tier          = lookup(var.statuses, each.key, var.default_status) == "ON" ? "Standard" : "Free"
  resource_type = each.value
  subplan       = lookup(var.subplans, each.key, var.default_subplan)
}
