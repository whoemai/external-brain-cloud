resource "azurerm_subnet" "snet" {
  name                      = "snet-${var.customer}-${var.component}-${var.env}-${var.locationshort}-001"
  resource_group_name       = var.resourcegroup
  virtual_network_name      = var.vnet
  address_prefixes          = var.addr_prefix
}