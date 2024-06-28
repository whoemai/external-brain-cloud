# module "modelo-snet" {
#     source              = "../modules/subnet"

#     resourcegroup       = module.hub-vnet-rg.rg-name
#     vnet                = module.hub-vnet.vnet-name
#     location            = var.location
#     env                 = var.env
#     customer            = var.customer
#     component           = var.component
# }


# ["10.250.0.0/24"]