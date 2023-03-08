output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = module.mdc_plans_enable.subscription_pricing_id
}

output "plans_details" {
  description = "All plans details"
  value       = module.mdc_plans_enable.plans_details
}
