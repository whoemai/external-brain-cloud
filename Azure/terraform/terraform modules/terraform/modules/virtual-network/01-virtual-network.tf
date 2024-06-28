resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.customer}-${var.component}-${var.env}-${var.locationshort}-001"
  location            = var.location
  resource_group_name = var.resourcegroup
  address_space       = var.addr_space
}