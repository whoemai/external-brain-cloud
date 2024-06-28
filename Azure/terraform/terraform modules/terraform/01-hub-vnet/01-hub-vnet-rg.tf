module "hub-vnet-rg" {
    source          = "../modules/resource-group"

    location            = var.location
    locationshort       = var.locationshort
    env                 = var.env
    product             = var.customer
    component           = "nw"
}