data "azurerm_subscription" "current" {}

# Enabling Vulnerability assessment for machines
resource "azurerm_subscription_policy_assignment" "va_auto_provisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  name                 = "mdc-va-autoprovisioning"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/13ce0167-8ca6-4048-8e6b-f996402e3c1b"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Configure machines to receive a vulnerability assessment provider"
  location             = "West Europe"
  parameters           = local.va_type

  identity {
    type = "SystemAssigned"
  }
  # For MDE vulnerability assessmen vaType should be "mdeTvm", for using Qualys vaType should be "default".
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

data "azurerm_role_definition" "security_admin" {
  name = "Security Admin"
}

resource "azurerm_role_assignment" "va_auto_provisioning_identity_role" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  principal_id       = azurerm_subscription_policy_assignment.va_auto_provisioning[count.index].identity[0].principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = data.azurerm_role_definition.security_admin.id

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling Endpoint protection
resource "azurerm_security_center_setting" "setting_mcas" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  enabled      = true
  setting_name = "WDATP"

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

data "azurerm_policy_definition" "vm_policies" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.log_analytics_policies : {}

  display_name = each.value.definition_display_name
}

# Enabling Log Analytics agent auto-provisioning
resource "azurerm_subscription_policy_assignment" "vm" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.log_analytics_policies : {}

  name                 = each.key
  policy_definition_id = data.azurerm_policy_definition.vm_policies[each.key].id
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = each.value.display_name
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

resource "azurerm_security_center_auto_provisioning" "auto_provisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  auto_provision = "On"

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

data "azurerm_policy_definition" "container_policies" {
  for_each = contains(var.mdc_plans_list, "Containers") ? local.container_policies : {}

  display_name = each.value.definition_display_name
}

# Enabling Azure Policy for Kubernetes + Defender DaemonSet
resource "azurerm_subscription_policy_assignment" "container" {
  for_each = contains(var.mdc_plans_list, "Containers") ? local.container_policies : {}

  name                 = each.key
  policy_definition_id = data.azurerm_policy_definition.container_policies[each.key].id
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = each.value.display_name
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}