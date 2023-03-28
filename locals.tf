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
  va_type = jsonencode({
    "vaType" = {
      "value" = "mdeTvm"
    }
  })
  virtual_machine_policies = {
    mdc-va-autoprovisioning = {
      definition_display_name = "Configure machines to receive a vulnerability assessment provider"
    }
    mdc-log-analytics-arc1-autoprovisioning = {
      definition_display_name = "[Preview]: Configure Azure Arc-enabled Windows machines with Log Analytics agents connected to default Log Analytics workspace"
    }
    mdc-log-analytics-arc2-autoprovisioning = {
      definition_display_name = "[Preview]: Configure Azure Arc-enabled Linux machines with Log Analytics agents connected to default Log Analytics workspace"
    }
  }
}