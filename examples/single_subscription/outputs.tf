output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = module.enable_mdc_plans[*].subscription_pricing_id
}