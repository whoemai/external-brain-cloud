resource "azurerm_virtual_desktop_workspace_application_group_association" "avd" {
    workspace_id                = azurerm_virtual_desktop_workspace.avd.id
    application_group_id        = azurerm_virtual_desktop_application_group.avd.id
}