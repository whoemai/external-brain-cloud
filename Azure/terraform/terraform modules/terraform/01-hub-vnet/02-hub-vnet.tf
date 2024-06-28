module "hub-vnet" {
    source              = "../modules/virtual-network"

    resourcegroup       = module.hub-vnet-rg.rg-name
    location            = var.location
    locationshort       = var.locationshort
    env                 = var.env
    customer            = var.customer
    resource            = "hub"#var.resource
    addr_space          = ["10.250.0.0/24"] #var.addr_space
}