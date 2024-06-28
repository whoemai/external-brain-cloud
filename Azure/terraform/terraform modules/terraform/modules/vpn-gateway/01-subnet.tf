resource "azurerm_subnet" "vpn-gw" {
  name                      = "GatewaySubnet"
  resource_group_name       = var.resourcegroup
  virtual_network_name      = var.vnet
  address_prefixes          = var.addr_prefix
}