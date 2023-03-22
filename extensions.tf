data "azurerm_subscription" "current" {}

locals {
  va_type = jsonencode({
    "vaType" = {
      "value" = "mdeTvm"
    }
  })
}

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

resource "azurerm_role_assignment" "va_auto_provisioning_identity_role" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  principal_id       = azurerm_subscription_policy_assignment.va_auto_provisioning[count.index].identity[0].principal_id
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "/providers/Microsoft.Authorization/roleDefinitions/fb1c8493-542b-48eb-b624-b4c8fea62acd"

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

# Enabling Log Analytics agent auto-provisioning
resource "azurerm_security_center_auto_provisioning" "auto_provisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  auto_provision = "On"

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

resource "azurerm_subscription_policy_assignment" "log_analytics_arc1_autoprovisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  name                 = "mdc-Log-Analytics-Arc1-autoprovisioning"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/594c1276-f44f-482d-9910-71fac2ce5ae0"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Configure machines to receive a Log Analytics 1 provider"
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

resource "azurerm_subscription_policy_assignment" "log_analytics_arc2_autoprovisioning" {
  count = contains(var.mdc_plans_list, "VirtualMachines") ? 1 : 0

  name                 = "mdc-Log-Analytics-Arc2-autoprovisioning"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bacd7fca-1938-443d-aad6-a786107b1bfb"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Configure machines to receive a Log Analytics 2 provider"
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["VirtualMachines"]
  ]
}

# Enabling Azure Policy for Kubernetes
resource "azurerm_subscription_policy_assignment" "containers_kubernetes1_autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0

  name                 = "mdc-containers-Kubernetes1-autoprovisioning"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0adc5395-9169-4b9b-8687-af838d69410a"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Configure machines to receive an Azure Policy for Kubernetes"
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}

resource "azurerm_subscription_policy_assignment" "containers_kubernetes2_autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0

  name                 = "mdc-containers-Kubernetes2-autoprovisioning"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a8eff44f-8c92-45c3-a3fb-9880802d67a7"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Configure machines to receive an Azure Policy for Kubernetes"
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}

# Enabling Defender DaemonSet
resource "azurerm_subscription_policy_assignment" "containers_aks_autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0

  name                 = "mdc-containers-AKS-autoprovisioning"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/64def556-fbad-4622-930e-72d1d5589bf5"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Configure machines to receive a Defender DaemonSet provider"
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}

resource "azurerm_subscription_policy_assignment" "containers_arc_autoprovisioning" {
  count = contains(var.mdc_plans_list, "Containers") ? 1 : 0

  name                 = "mdc-containers-Arc-autoprovisioning"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/708b60a6-d253-4fe0-9114-4be4c00f012c"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Configure machines to receive a Defender DaemonSet provider"
  location             = "West Europe"

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_security_center_subscription_pricing.asc_plans["Containers"]
  ]
}
