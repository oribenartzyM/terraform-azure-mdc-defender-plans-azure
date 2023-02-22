output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = { for plan, pricing in azurerm_security_center_subscription_pricing.asc_plans : plan => pricing.id }
}
