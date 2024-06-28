module "vpn-conn-02" {
    source              = "../modules/vpn-connection"

    resourcegroup       = module.hub-vpn-rg.rg-name
    location            = var.location
    locationshort       = var.locationshort
    env                 = var.env
    customer            = var.customer
    peername            = "sitesp"
    lgwaddr             = "1.2.3.4"
    addrspace           = ["192.168.0.0/24"]
    vpngwid             = module.vpn-gw.vpn-gw-id
    psk                 = "abcdefghijklmnopqrstuvwxyz"
}