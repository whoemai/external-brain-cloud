resource "azurerm_virtual_network" "avd" {
    name                    = "vnet-${var.suffix}"
    location                = azurerm_resource_group.avd.location
    resource_group_name     = azurerm_resource_group.avd.name
    address_space           = ["${var.vnet}"]
    #dns_servers             = 
}

resource "azurerm_subnet" "avd" {
    name                        = "snet-${var.suffix}"
    resource_group_name         = azurerm_resource_group.avd.name
    virtual_network_name        = azurerm_virtual_network.avd.name
    address_prefixes            = ["${var.snet}"]

}