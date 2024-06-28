resource "azurerm_resource_group" "avd" {
    name        = "rg-${var.suffix}"
    location    = "${var.location}"
}