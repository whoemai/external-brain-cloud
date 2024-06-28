resource "azurerm_local_network_gateway" "lgw" {
    name                    = "lgw-${var.peername}-${var.env}-${var.locationshort}-001"
    resource_group_name     = var.resourcegroup
    location                = var.location
    gateway_address         = var.lgwaddr
    address_space           = var.addrspace
}