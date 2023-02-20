variable "tier" {
  type        = string
  description = "The pricing tier to use. Valid values are (Free, Standard)"
  default     = "Standard"
  nullable    = false
}

variable "mdc_plans_list" {
  type        = list(string)
  description = "List of all MDC plans"
  default     = ["AppServices", "ContainerRegistry", "KeyVaults", "KubernetesService", "SqlServers", "SqlServerVirtualMachines", "StorageAccounts", "VirtualMachines", "Arm", "Dns", "OpenSourceRelationalDatabases", "Containers", "CloudPosture"]
  nullable    = false
}

variable "subplan" {
  type        = string
  description = "Resource type pricing subplan. Contact your MSFT representative for possible values"
  default     = ""
}