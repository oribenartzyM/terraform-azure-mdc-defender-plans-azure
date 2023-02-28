output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = module.enable_mdc_plans.subscription_pricing_id
}
  
output "plans_and_subplans" {
  description = "The plan subplan"
  value       = module.enable_mdc_plans.plans_and_subplans
}
