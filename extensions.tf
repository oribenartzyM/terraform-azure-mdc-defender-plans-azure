data "azurerm_subscription" "current" {}


# Enabling vm extensions - Log Analytics for arc and vulnerability assessment
data "azurerm_policy_definition" "vm_policies" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_policies : {}

  display_name = each.value.definition_display_name
}

resource "azurerm_subscription_policy_assignment" "vm" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_policies : {}

  name                 = each.key
  policy_definition_id = data.azurerm_policy_definition.vm_policies[each.key].id
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = each.value.definition_display_name
  location             = var.location
  parameters           = each.key == "mdc-va-autoprovisioning" ? local.va_type : null

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling vm extensions - Log Analytics for vm
resource "azurerm_security_center_auto_provisioning" "auto_provisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  auto_provision = "On"

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling vm extensions - Endpoint protection
resource "azurerm_security_center_setting" "setting_mcas" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  enabled      = true
  setting_name = "WDATP"

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling vm Roles
data "azurerm_role_definition" "vm_roles" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_roles : {}
  
  name = each.value.name
}

resource "azurerm_role_assignment" "va_auto_provisioning_vm_role" {
  for_each = contains(var.mdc_plans_list, "VirtualMachines") ? local.virtual_machine_roles : {}

  principal_id       = azurerm_subscription_policy_assignment.vm[each.value.policy].identity[0].principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = data.azurerm_role_definition.vm_roles[each.key].id

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling Containers Extensions - Azure Policy for Kubernetes + Defender DaemonSet
data "azurerm_policy_definition" "container_policies" {
  for_each = contains(var.mdc_plans_list, "Containers") ? local.container_policies : {}

  display_name = each.value.definition_display_name
}

resource "azurerm_subscription_policy_assignment" "container" {
  for_each = contains(var.mdc_plans_list, "Containers") ? local.container_policies : {}

  name                 = each.key
  policy_definition_id = data.azurerm_policy_definition.container_policies[each.key].id
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = each.value.definition_display_name
  location             = var.location

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}

# Enabling Containers Roles
data "azurerm_role_definition" "container_roles" {
  for_each = contains(var.mdc_plans_list, "Containers") ? local.container_roles : {}

  name = each.value.name
}

resource "azurerm_role_assignment" "va_auto_provisioning_containers_role" {
  for_each = contains(var.mdc_plans_list, "Containers") ? local.container_roles : {}

  principal_id       = azurerm_subscription_policy_assignment.container[each.value.policy].identity[0].principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = data.azurerm_role_definition.container_roles[each.key].id

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}