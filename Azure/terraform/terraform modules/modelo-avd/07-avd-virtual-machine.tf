resource "azurerm_network_interface" "avd" {
    count                   = "${var.vmcount}"
    name                    = "nic-vm-${var.suffix}-${count.index}"
    location                = azurerm_resource_group.avd.location
    resource_group_name     = azurerm_resource_group.avd.name

    ip_configuration {
        name                                = "ipconfig"
        subnet_id                           = azurerm_subnet.avd.id
        private_ip_address_allocation       = "dynamic"
    }
}


resource "azurerm_windows_virtual_machine" "avd" {
    count                       = "${var.vmcount}"
    name                        = "vm-${var.suffix}-${count.index}"
    resource_group_name         = azurerm_resource_group.avd.name
    location                    = azurerm_resource_group.avd.location
    size                        = "${var.vmsize}"
    admin_username              = "${var.localusername}"
    admin_password              = "${var.localpassword}"
    network_interface_ids       = [ azurerm_network_interface.avd[count.index].id ]

    os_disk {
        caching                     = "ReadWrite"
        storage_account_type        = "Standard_LRS"
    }

    source_image_reference {
        publisher       = "${var.img_publisher}"
        offer           = "${var.img_offer}"
        sku             = "${var.img_sku}"
        version         = "${var.img_version}"
    }
}