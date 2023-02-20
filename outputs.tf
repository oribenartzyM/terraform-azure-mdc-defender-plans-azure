output "subscription_pricing_id" {
  description = "The subscription pricing ID"
  value       = azurerm_security_center_subscription_pricing.asc_plans[*].id
}