variable "default_subplan" {
  type        = string
  description = "(Optional) Resource type pricing default subplan. Contact your MSFT representative for possible values"
  default     = null
}

variable "default_tier" {
  type        = string
  description = "(Optional) Default pricing tier to use. Valid values are `ON`, `OFF`"
  default     = "ON"
  nullable    = false
}

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
  nullable = false
}

variable "subplans" {
  type        = map(string)
  description = "(Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values"
  default     = {}
  nullable    = false
}

variable "Statuses" {
  type        = map(string)
  description = "(Optional) A map of the pricing tiers to use, the key is resource type. This variable takes precedence over `var.default_status`."
  default     = {}
  nullable    = false
}
