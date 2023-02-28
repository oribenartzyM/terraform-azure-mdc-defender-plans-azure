output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = module.enable_mdc_plans.subscription_pricing_id
}
  
output "plans_details" {
  description = "All plans details"
  value       = module.enable_mdc_plans.plans_details
}
