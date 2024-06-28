resource "azurerm_virtual_desktop_host_pool" "avd" {
    location                                = azurerm_resource_group.avd.location
    resource_group_name                     = azurerm_resource_group.avd.name
    
    name                                    = "vdpool-${var.suffix}"
    friendly_name                           = "vdpool-${var.suffix}"
    validate_environment                    = true
    start_vm_on_connect                     = true
    custom_rdp_properties                   = "audiocapturemode:i:1;audiomode:i:0;"
    description                             = "HostPool de Teste"
    type                                    = "Personal"
    load_balancer_type                      = "Persistent"
    personal_desktop_assignment_type        = "Automatic"
    
    registration_info {
      expiration_date                       = timeadd(timestamp(), "20d")
    }

}