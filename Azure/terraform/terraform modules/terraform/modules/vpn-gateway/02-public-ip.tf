resource "azurerm_public_ip" "vpn-gw" {
    name                    = "pip-vgw-${var.customer}-${var.env}-${var.locationshort}-001"
    resource_group_name     = var.resourcegroup
    location                = var.location
    allocation_method       = "Static"
    sku                     = "Standard"
    zones                   = ["1","2","3"]
}