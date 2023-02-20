module "enable_mdc_plans" {
  source         = "../modules/mdc-plans"
  tier           = var.tier
  mdc_plans_list = var.mdc_plans_list
  subplan        = var.subplan
}