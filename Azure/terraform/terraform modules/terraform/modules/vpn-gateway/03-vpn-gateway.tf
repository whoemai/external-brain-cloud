resource "azurerm_virtual_network_gateway" "vpn-gw" {
    name                    = "vgw-${var.customer}-${var.env}-${var.locationshort}-001"
    resource_group_name     = var.resourcegroup
    location                = var.location

    type                    = "Vpn"
    active_active           = false
    enable_bgp              = false
    sku                     = var.sku
    generation              = var.generation

    ip_configuration {
        subnet_id                   = azurerm_subnet.vpn-gw.id
        public_ip_address_id        = azurerm_public_ip.vpn-gw.id
    }
}