module "enable_mdc_plans" {
  source         = "../.."
  default_status   = var.status
  mdc_plans_list = var.mdc_plans_list
  subplans       = var.subplans
}
