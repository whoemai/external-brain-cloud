#Cloud #Azure #Terraform 

```hcl
terraform {
    backend "azurerm" {
        # resource_group_name = "rg-terraform-backend"
        # storage_account_name = "strecterraformbackend"
        # container_name = "terraform-tfstate"
        # key = "tf-az-#NOME_DO_RECURSO#.tfstate"
    }
    required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.5.0"
    }
  }
}

# terraform {
#   backend "local" {}
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.5.0"
#     }
#   }
# }
```