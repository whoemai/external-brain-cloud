resource "azurerm_virtual_desktop_application_group" "avd" {
    name                    = "vdag-${var.suffix}"
    location                = azurerm_resource_group.avd.location
    resource_group_name     = azurerm_resource_group.avd.name

    type                    = "Desktop"
    host_pool_id            = azurerm_virtual_desktop_host_pool.avd.id
    friendly_name           = "AVD Desktop"
    description             = "Desktop Remoto"
}