resource azurerm_resource_group "rg" {
    name            = "rg-${var.customer}-${var.component}-${var.env}-${var.locationshort}-001"
    location        = var.location
}