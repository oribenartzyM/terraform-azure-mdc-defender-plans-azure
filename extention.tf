
data "azurerm_subscription" "current" {}

# Enabling Vulnerability assessment for machines
resource "azurerm_subscription_policy_assignment" "va_auto_provisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0
  name                 = "mdc-va-autoprovisioning"
  display_name         = "Configure machines to receive a vulnerability assessment provider"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/13ce0167-8ca6-4048-8e6b-f996402e3c1b"
  subscription_id      = data.azurerm_subscription.current.id
  identity {
    type = "SystemAssigned"
  }
  location = "West Europe"
  # For MDE vulnerability assessmen vaType should be "mdeTvm", for using Qualys vaType should be "default".
  parameters = <<PARAMS
{ "vaType": { "value": "mdeTvm" } }
PARAMS
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

resource "azurerm_role_assignment" "va-auto-provisioning-identity-role" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "/providers/Microsoft.Authorization/roleDefinitions/fb1c8493-542b-48eb-b624-b4c8fea62acd"
  principal_id       = azurerm_subscription_policy_assignment.va_auto_provisioning[count.index].identity[0].principal_id
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling Endpoint protection
resource "azurerm_security_center_setting" "setting_mcas" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0
  setting_name = "WDATP"
  enabled      = true
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

#Enabling Log Analytics agent auto-provisioning
resource "azurerm_security_center_auto_provisioning" "auto-provisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0
  auto_provision = "On"
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling Azure Policy for Kubernetes
resource "azurerm_subscription_policy_assignment" "containers-Kubernetes1-autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0
  name                 = "mdc-containers-Kubernetes1-autoprovisioning"
  display_name         = "Configure machines to receive an Azure Policy for Kubernetes"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0adc5395-9169-4b9b-8687-af838d69410a"
  subscription_id      = data.azurerm_subscription.current.id
  identity {
    type = "SystemAssigned"
  }
  location = "West Europe"
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}

resource "azurerm_subscription_policy_assignment" "containers-Kubernetes2-autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0
  name                 = "mdc-containers-Kubernetes2-autoprovisioning"
  display_name         = "Configure machines to receive an Azure Policy for Kubernetes"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a8eff44f-8c92-45c3-a3fb-9880802d67a7"
  subscription_id      = data.azurerm_subscription.current.id
  identity {
    type = "SystemAssigned"
  }
  location = "West Europe"
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}

#Enabling Defender DaemonSet
resource "azurerm_subscription_policy_assignment" "containers-AKS-autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0
  name                 = "mdc-containers-AKS-autoprovisioning"
  display_name         = "Configure machines to receive a Defender DaemonSet provider"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/64def556-fbad-4622-930e-72d1d5589bf5"
  subscription_id      = data.azurerm_subscription.current.id
  identity {
    type = "SystemAssigned"
  }
  location = "West Europe"
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}

resource "azurerm_subscription_policy_assignment" "containers-Arc-autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0
  name                 = "mdc-containers-Arc-autoprovisioning"
  display_name         = "Configure machines to receive a Defender DaemonSet provider"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/708b60a6-d253-4fe0-9114-4be4c00f012c"
  subscription_id      = data.azurerm_subscription.current.id
  identity {
    type = "SystemAssigned"
  }
  location = "West Europe"
  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}