module "hub-vpn-gw" {
    source              = "../modules/vpn-gateway"

    resourcegroup       = module.hub-vpn-rg.rg-name
    vnet                = module.hub-vnet.vnet-name
    location            = var.location
    locationshort       = var.locationshort
    env                 = var.env
    customer            = var.component
    addr_prefix         = ["10.250.0.0/27"]
    sku                 = "VpnGw1AZ"
    generation          = "Generation1"
}