module "enable_mdc_plans" {
  source         = "../.."
  default_tier   = var.tier
  mdc_plans_list = var.mdc_plans_list
  subplans       = var.subplans
}
