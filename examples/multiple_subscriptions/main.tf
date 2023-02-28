resource "local_file" "generate_main_terraform_file" {
  filename = "${path.module}/MDC_Plans/main.tf"
  content = templatefile("resolv.conf.tftpl", {
    list_of_subscriptions = local.list_of_subscriptions
    tier                  = var.status
    mdc_plans_list        = jsonencode(var.mdc_plans_list)
    subplan               = var.subplan
  })
}
