resource "azurerm_virtual_machine_extension" "avd-domainjoin" {
    count                       = "${var.vmcount}"
    name                        = "domainjoin"
    virtual_machine_id          = azurerm_windows_virtual_machine.avd[count.index].id
    publisher                   = "Microsoft.Compute"
    type                        = "JsonADDomainExtension"
    type_handler_version        = "1.3"
    depends_on                  = [ azurerm_virtual_machine_extension.avd-registersessionhost ]
    # Configurações: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain

    settings = <<SETTINGS
    {
        "Name": "${var.domain_dnsname}",
        "OUPath": "${var.domain_oupath}",
        "User": "${var.domain_joinuser}",
        "Restart": "true",
        "Options": "3"
    }
    SETTINGS

    protected_settings = <<PROTECTED_SETTINGS
    {
        "Password": "${var.domain_joinuserpassword}"
    }
    PROTECTED_SETTINGS
}