variable "subscription_id" {
  type        = string
  description = "(Required) Azure subscription ID"

  validation {
    condition     = length(var.subscription_id) > 0
    error_message = "[subscription_id] value cannot be an empty string)"
  }
}

variable "tier" {
  type        = string
  description = "(Optional) The pricing tier to use. Valid values are (Free, Standard)"
  default     = "Standard"
}

variable "mdc_plans_list" {
  type        = list(string)
  description = "(Optional) List of all MDC plans"
  default     = ["AppServices", "ContainerRegistry", "KeyVaults", "KubernetesService", "SqlServers", "SqlServerVirtualMachines", "StorageAccounts", "VirtualMachines", "Arm", "Dns", "OpenSourceRelationalDatabases", "Containers", "CloudPosture"]
}

variable "subplan" {
  type        = string
  description = "(Optional)Resource type pricing subplan. Contact your MSFT representative for possible values"
  default     = ""
}