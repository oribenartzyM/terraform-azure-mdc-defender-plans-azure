variable "mdc_plans_list" {
  type        = set(string)
  description = "(Optional) Set of all MDC plans"
  default = [
    "AppServices",
    "Arm",
    "CloudPosture",
    "ContainerRegistry",
    "Containers",
    "Dns",
    "KeyVaults",
    "KubernetesService",
    "OpenSourceRelationalDatabases",
    "SqlServers",
    "SqlServerVirtualMachines",
    "StorageAccounts",
    "VirtualMachines",
  ]
}

variable "subplans" {
  type        = map(string)
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values"
  default = {}
}

variable "status" {
  type        = string
  description = "(Optional) The pricing tier to use. Valid values are `ON`, `OFF`"
  default     = "ON"
}
