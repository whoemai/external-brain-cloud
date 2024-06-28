resource "azurerm_virtual_machine_extension" "avd-registersessionhost" {
    count                           = "${var.vmcount}"
    name                            = "registersessionhost"
    virtual_machine_id              = azurerm_windows_virtual_machine.avd[count.index].id
    publisher                       = "Microsoft.Powershell"
    type                            = "DSC"
    type_handler_version            = "2.73"
    auto_upgrade_minor_version      = true
    depends_on                      = [ azurerm_windows_virtual_machine.avd ]
    settings = <<SETTINGS
        {
            "ModulesUrl": "${var.artifactslocation}",
            "ConfigurationFunction": "Configuration.ps1\\AddSessionHost",
            "Properties": {
                "hostPoolName": "${azurerm_virtual_desktop_host_pool.avd.name}",
                "registrationInfoToken": "${azurerm_virtual_desktop_host_pool.avd.registration_info.0.token}"
            }
        }
    SETTINGS
}