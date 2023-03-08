locals {
  final_plans_list = contains(var.mdc_plans_list, "Databases") ? setsubtract(setunion(var.mdc_plans_list, var.mdc_databases_plans), ["Databases"]) : var.mdc_plans_list

  # Limiting the subplans to "VirtualMachines" only.
  # updated_subplans = { for k, v in var.subplans : k => v if k == "VirtualMachines" }
}

resource "azurerm_security_center_subscription_pricing" "asc_plans" {
  for_each = local.final_plans_list

  tier          = lookup(var.statuses, each.key, var.default_status) ? "Standard" : "Free"
  resource_type = each.value
  # For enable plans, "StorageAccounts" subplan is "PerStorageAccount" and only "VirtualMachines" subplan is configurable. For disable plans, subplan is not required == null.
  subplan = lookup(var.statuses, each.key, var.default_status) ? lookup(var.subplans, each.key, each.key == "StorageAccounts" ? "PerStorageAccount" : var.default_subplan) : null
}
