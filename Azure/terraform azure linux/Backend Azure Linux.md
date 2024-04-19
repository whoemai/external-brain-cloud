#Cloud #Azure #Terraform #Linux

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

# Configuração do Terraform para Provedor Azure

Aqui está a explicação para o trecho de código que configura o provedor Azure:
## 6. **Configuração do Provedor Azure**

```hcl
provider "azurerm" {
  features {}
  skip_provider_registration = true
}
```

- **Descrição**: Este bloco define o provedor Azure para o Terraform.
- **Responsabilidade**: O provedor Azure permite que o Terraform interaja com os recursos da Microsoft Azure.
- **Detalhes**:
    - `features {}`: Isso indica que nenhuma funcionalidade específica do provedor está sendo ativada.
    - `skip_provider_registration = true`: Isso evita o registro automático do provedor Azure. Em alguns casos, você pode querer registrar manualmente o provedor antes de executar o Terraform.

Lembre-se de configurar as variáveis e os detalhes específicos do provedor Azure conforme necessário para o seu ambiente.