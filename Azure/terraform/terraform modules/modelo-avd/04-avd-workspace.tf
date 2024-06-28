resource "azurerm_virtual_desktop_workspace" "avd" {
    name                    = "vdws-${var.suffix}"
    location                = azurerm_resource_group.avd.location
    resource_group_name     = azurerm_resource_group.avd.name

    friendly_name           = "AVD Workspace"
    description             = "Workspace para teste"
}