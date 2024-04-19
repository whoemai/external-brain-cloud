#Azure #Terraform #Cloud

```hcl
# Recurso de grupo Azure Resource Group
data "azurerm_resource_group" "res-2" {
  name = "xxx" // Preencher com o nome do grupo de recursos para implantação
}

# Chave do Azure Key Vault
data "azurerm_key_vault" "kv-infraestrutura" {
  name                = "xxx" // Nome do KeyVault, alterar de acordo com o ambiente
  resource_group_name = "xxx" // Nome do grupo de recursos da Key Vault, alterar de acordo com o ambiente
}

# Segredo do Azure Key Vault para a senha do servidor administrador
data "azurerm_key_vault_secret" "PasswordServerAdmin" {
  name         = var.passwordserveradmin
  key_vault_id = data.azurerm_key_vault.kv-infraestrutura.id
}

# Gerador de número inteiro aleatório
resource "random_integer" "id" {
  min = 111
  max = 999
}

# Máquina virtual Windows Azure
resource "azurerm_windows_virtual_machine" "res-1" {
  admin_username        = var.admin_username
  admin_password        = data.azurerm_key_vault_secret.PasswordServerAdmin.value  
  license_type          = "Windows_Server"
  location              = data.azurerm_resource_group.res-2.location
  name                  = "xxx" // Alterar nome da máquina conforme o padrão de exemplo
  network_interface_ids = [azurerm_network_interface.res-0.id]
  resource_group_name   = data.azurerm_resource_group.res-2.name
  size                  = var.vm_size
  zone                  = "1"
  boot_diagnostics {
  }
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-0,
  ]
}

# Interface de rede Azure Network Interface
resource "azurerm_network_interface" "res-0" {
  location            = data.azurerm_resource_group.res-2.location
  name                = format("xxx-%v", random_integer.id.result)
  resource_group_name = data.azurerm_resource_group.res-2.name
  dns_servers         = var.dns_servers 
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = var.private_ip_address_allocation
    subnet_id                     = "xxx" // Preencher com a informação da VNet e Subnet
  }
  depends_on = [
    data.azurerm_resource_group.res-2,
  ]
}
```

---
# Documentação da Configuração de Recursos Azure com Terraform

Este documento descreve a configuração de recursos Azure usando Terraform. O código fornecido define vários recursos, como grupos de recursos, máquinas virtuais Windows, chaves do Azure Key Vault e muito mais. A seguir, vamos detalhar cada parte do código.

## Recurso de Grupo Azure Resource Group

```hcl
data "azurerm_resource_group" "res-2" {
  name = "xxx" // Preencher com o nome do grupo de recursos para implantação
}
```

Este bloco de código define um recurso de grupo Azure Resource Group. O campo `name` deve ser preenchido com o nome do grupo de recursos a ser implantado.

## Chave do Azure Key Vault

```hcl
data "azurerm_key_vault" "kv-infraestrutura" {
  name                = "xxx" // Nome do KeyVault, alterar de acordo com o ambiente
  resource_group_name = "xxx" // Nome do grupo de recursos da Key Vault, alterar de acordo com o ambiente
}
```

Este bloco de código define uma chave do Azure Key Vault. Substitua os campos `name` e `resource_group_name` pelos valores apropriados de acordo com seu ambiente.

## Segredo do Azure Key Vault para a senha do servidor administrador

```hcl
data "azurerm_key_vault_secret" "PasswordServerAdmin" {
  name         = var.passwordserveradmin
  key_vault_id = data.azurerm_key_vault.kv-infraestrutura.id
}
```

Este bloco de código obtém um segredo do Azure Key Vault para a senha do servidor administrador. Ele usa a variável `var.passwordserveradmin` e a referência à chave do Azure Key Vault definida anteriormente.

## Gerador de Número Inteiro Aleatório

```hcl
resource "random_integer" "id" {
  min = 111
  max = 999
}
```

Este recurso cria um gerador de número inteiro aleatório com valores entre 111 e 999. O resultado pode ser referenciado como `random_integer.id.result`.

## Máquina Virtual Windows Azure

```hcl
resource "azurerm_windows_virtual_machine" "res-1" {
  // Configurações da máquina virtual
}
```

Este bloco de código define uma máquina virtual Windows Azure com várias configurações, como nome de usuário, senha, tipo de licença, localização e muito mais. Certifique-se de preencher os campos apropriados com os valores necessários para a sua máquina virtual.

## Interface de Rede Azure Network Interface

```hcl
resource "azurerm_network_interface" "res-0" {
  // Configurações da interface de rede
}
```

Este bloco de código define uma interface de rede Azure Network Interface. Ele inclui configurações relacionadas à localização, nome, endereços IP, VNet e Subnet. Substitua os valores apropriados de acordo com sua rede.

Este é um resumo da documentação para o código fornecido. Certifique-se de preencher todos os campos relevantes com os valores específicos do seu ambiente antes de implantar esses recursos no Azure usando o Terraform.
```

Lembre-se de substituir os comentários em maiúsculas (por exemplo, `xxx`) pelos valores específicos do seu ambiente. Esta documentação em Markdown deve ajudá-lo a entender e compartilhar a configuração de recursos Azure com sua equipe.