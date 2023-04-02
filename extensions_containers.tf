locals {
  container_policies = {
    mdc-containers-kubernetes1-autoprovisioning = {
      definition_display_name = "Configure Azure Arc enabled Kubernetes clusters to install the Azure Policy extension"
    }
    mdc-containers-kubernetes2-autoprovisioning = {
      definition_display_name = "Deploy Azure Policy Add-on to Azure Kubernetes Service clusters"
    }
    mdc-containers_aks_autoprovisioning = {
      definition_display_name = "Configure Azure Kubernetes Service clusters to enable Defender profile"
    }
    mdc-containers-arc-autoprovisioning = {
      definition_display_name = "[Preview]: Configure Azure Arc enabled Kubernetes clusters to install Microsoft Defender for Cloud extension"
    }
  }
  container_roles = {
    role-1 = {
      name   = "Kubernetes Extension Contributor"
      policy = "mdc-containers-kubernetes1-autoprovisioning"
    }
    role-2 = {
      name   = "Azure Kubernetes Service Contributor Role"
      policy = "mdc-containers-kubernetes2-autoprovisioning"
    }
    role-3 = {
      name   = "Azure Kubernetes Service Policy Add-on Deployment"
      policy = "mdc-containers-kubernetes2-autoprovisioning"
    }
    role-4 = {
      name   = "Log Analytics Contributor"
      policy = "mdc-containers_aks_autoprovisioning"
    }
    role-5 = {
      name   = "Contributor"
      policy = "mdc-containers_aks_autoprovisioning"
    }
    role-6 = {
      name   = "Log Analytics Contributor"
      policy = "mdc-containers-arc-autoprovisioning"
    }
    role-7 = {
      name   = "Contributor"
      policy = "mdc-containers-arc-autoprovisioning"
    }
  }
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