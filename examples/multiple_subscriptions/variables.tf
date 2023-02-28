variable "mdc_plans_list" {
  type        = list(string)
  description = "(Optional) List of all MDC plans"
  default     = ["AppServices", "ContainerRegistry", "KeyVaults", "KubernetesService", "SqlServers", "SqlServerVirtualMachines", "StorageAccounts", "VirtualMachines", "Arm", "Dns", "OpenSourceRelationalDatabases", "Containers", "CloudPosture"]
}

variable "subplan" {
  type        = string
  description = "(Optional) Resource type pricing subplan. Contact your MSFT representative for possible values"
  default     = ""
}

variable "status" {
  type        = string
  description = "(Optional) The pricing tier to use. Valid values are (ON, OFF)"
  default     = "ON"
}
