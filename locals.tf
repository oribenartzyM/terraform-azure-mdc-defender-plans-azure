locals {
  container_policies = {
    mdc-containers-kubernetes1-autoprovisioning = {
      display_name            = "Configure machines to receive an Azure Policy for Kubernetes"
      definition_display_name = "Configure Azure Arc enabled Kubernetes clusters to install the Azure Policy extension"
    }
    mdc-containers-kubernetes2-autoprovisioning = {
      display_name            = "Configure machines to receive an Azure Policy for Kubernetes"
      definition_display_name = "Deploy Azure Policy Add-on to Azure Kubernetes Service clusters"
    }
    mdc-containers_aks_autoprovisioning = {
      display_name            = "Configure machines to receive a Defender DaemonSet provider"
      definition_display_name = "Configure Azure Kubernetes Service clusters to enable Defender profile"
    }
    mdc-containers-arc-autoprovisioning = {
      display_name            = "Configure machines to receive a Defender DaemonSet provider"
      definition_display_name = "[Preview]: Configure Azure Arc enabled Kubernetes clusters to install Microsoft Defender for Cloud extension"
    }
  }
  log_analytics_policies = {
    mdc-log-analytics-arc1-autoprovisioning = {
      display_name            = "Configure machines to receive a Log Analytics 1 provider"
      definition_display_name = "[Preview]: Configure Azure Arc-enabled Windows machines with Log Analytics agents connected to default Log Analytics workspace"
    }
    mdc-log-analytics-arc2-autoprovisioning = {
      display_name            = "Configure machines to receive a Log Analytics 2 provider"
      definition_display_name = "[Preview]: Configure Azure Arc-enabled Linux machines with Log Analytics agents connected to default Log Analytics workspace"
    }
  }
  va_type = jsonencode({
    "vaType" = {
      "value" = "mdeTvm"
    }
  })

}