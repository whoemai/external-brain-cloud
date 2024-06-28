module "vpn-conn-01" {
    source              = "../modules/vpn-connection"

    resourcegroup       = module.hub-vpn-rg.rg-name
    location            = var.location
    locationshort       = var.locationshort
    env                 = var.env
    customer            = var.customer
    peername            = "claranet"
    lgwaddr             = "1.2.3.4"
    addrspace           = ["192.168.0.0/24"]
    vpngwid             = module.vpn-gw.vpn-gw-id
    psk                 = "abcdefghijklmnopqrstuvwxyz"
}