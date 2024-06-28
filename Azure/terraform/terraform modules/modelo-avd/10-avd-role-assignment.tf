data "azuread_user" "italo" {
    user_principal_name     = "italo.timoteo@cloudtarget.com.br"
}

resource "azurerm_role_assignment" "avd-avduser" {
    scope                       = azurerm_virtual_desktop_application_group.avd.id
    role_definition_name        = "Desktop Virtualization User"
    principal_id                = data.azuread_user.italo.id
}