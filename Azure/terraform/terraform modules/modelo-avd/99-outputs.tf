output "avd-hostpool-registrationtoken" {
    value           = azurerm_virtual_desktop_host_pool.avd.registration_info
    sensitive       = true
}