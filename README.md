# Microsoft Defender for Cloud

Terraform module for MDC onboarding

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version        |
|---------------------------------------------------------------------------|----------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3         |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.40, < 4.0 |

## Providers

| Name                                                          | Version        |
|---------------------------------------------------------------|----------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.40, < 4.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                           | Type     |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_security_center_subscription_pricing.asc_plans](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing) | resource |

## Inputs

| Name                                                                              | Description                                                                                                                                                                                  | Type          | Default                                                                                                                                                                                                                                                                                                              | Required |
|-----------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------:|
| <a name="input_default_subplan"></a> [default\_subplan](#input\_default\_subplan) | (Optional) Resource type pricing default subplan. Contact your MSFT representative for possible values                                                                                       | `string`      | `null`                                                                                                                                                                                                                                                                                                               |    no    |
| <a name="input_default_status"></a> [default\_status](#input\_default\_status)          | (Optional) Default status to use. Valid values are `ON`, `OFF`                                                                                                                  | `string`      | `"ON"`                                                                                                                                                                                                                                                                                                         |    no    |
| <a name="input_mdc_plans_list"></a> [mdc\_plans\_list](#input\_mdc\_plans\_list)  | (Optional) Set of all MDC plans                                                                                                                                                              | `set(string)` | <pre>[<br>  "AppServices",<br>  "Arm",<br>  "CloudPosture",<br>  "ContainerRegistry",<br>  "Containers",<br>  "Dns",<br>  "KeyVaults",<br>  "KubernetesService",<br>  "OpenSourceRelationalDatabases",<br>  "SqlServers",<br>  "SqlServerVirtualMachines",<br>  "StorageAccounts",<br>  "VirtualMachines"<br>]</pre> |    no    |
| <a name="input_subplans"></a> [subplans](#input\_subplans)                        | (Optional) A map of resource type pricing subplan, the key is resource type. This variable takes precedence over `var.default_subplan`. Contact your MSFT representative for possible values | `map(string)` | <pre>{<br>"StorageAccounts" : "PerTransaction",<br>"VirtualMachines" : "P2"<br>}</pre>                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_statuses"></a> [statuses](#input\_statuses)                                 | (Optional) A map of the status to use, the key is resource type and the value is status. This variable takes precedence over `var.default_status`.                                                              | `map(string)` | `{}`                                                                                                                                                                                                                                                                                                                 |    no    |

## Outputs

| Name                                                                                                          | Description                 |
|---------------------------------------------------------------------------------------------------------------|-----------------------------|
| <a name="output_subscription_pricing_id"></a> [subscription\_pricing\_id](#output\_subscription\_pricing\_id) | The subscription pricing ID |
<!-- END_TF_DOCS -->
