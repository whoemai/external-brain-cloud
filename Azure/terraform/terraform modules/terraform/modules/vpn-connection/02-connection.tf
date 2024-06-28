resource "azurerm_virtual_network_gateway_connection" "conn" {
    name                            = "conn-${var.customer}-to-${var.peername}-${var.env}-${var.locationshort}-001"
    location                        = var.location
    resource_group_name             = var.resourcegroup

    type                            = "IPsec"
    virtual_network_gateway_id      = var.vpngwid
    local_network_gateway_id        = azurerm_local_network_gateway.lgw.id

    shared_key                      = var.psk

    dpd_timeout_seconds             = "3600"
}