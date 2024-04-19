#Azure #Terraform #Cloud #Linux 

```hcl
data "azurerm_resource_group" "res-2" {
  name = var.resource_group_name
}
data "azurerm_key_vault" "kv-infraestrutura" {
  name                = var.kv_name
  resource_group_name = var.kv_resource_group_name
}
data "azurerm_key_vault_secret" "SSHPublicKey" {
  name         = var.sshsecretname
  key_vault_id = data.azurerm_key_vault.kv-infraestrutura.id
}
resource "random_integer" "id" {
  min = 111
  max = 999
}
resource "azurerm_linux_virtual_machine" "res-1" {
  admin_username        = var.admin_username
  location              = data.azurerm_resource_group.res-2.location
  name                  = var.vm_name
  #custom_data          = filebase64("./scripts/config.sh") // utilizado em caso de automações
  network_interface_ids = [azurerm_network_interface.res-0.id]
  resource_group_name   = data.azurerm_resource_group.res-2.name
  size                  = var.vm_size
  zone                  = "1"
  admin_ssh_key {
    username   = var.admin_username
    public_key = data.azurerm_key_vault_secret.SSHPublicKey.value
  }
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
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "canonical"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-0,
  ]
}
resource "azurerm_network_interface" "res-0" {
  location            = data.azurerm_resource_group.res-2.location
  name                = format("${var.vm_name}-${random_integer.id.result}")
  resource_group_name = data.azurerm_resource_group.res-2.name
  dns_servers         = var.dns_servers
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = var.private_ip_address_allocation
    subnet_id                     = var.subnet_id
  }
  depends_on = [
    data.azurerm_resource_group.res-2,
  ]
}
# Este bloco adiciona discos na maquina, por padrão é adicinado 1 disco extra de 32 GB nas vms Linux

resource "random_string" "disk2" {
  length           = 32
  special          = false
  override_special = "/@£$"
}
resource "azurerm_managed_disk" "disk2" {
  name                 = format("%v_disk2_%v", azurerm_linux_virtual_machine.res-1.name, random_string.disk2.result)
  location             = data.azurerm_resource_group.res-2.location
  resource_group_name  = data.azurerm_resource_group.res-2.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = 32
  zone                 = azurerm_linux_virtual_machine.res-1.zone
}
resource "azurerm_virtual_machine_data_disk_attachment" "disk2" {
  managed_disk_id    = azurerm_managed_disk.disk2.id
  virtual_machine_id = azurerm_linux_virtual_machine.res-1.id
  lun                = "10"
  caching            = "ReadWrite"
}
```

----
# Configuração do Terraform para Criar uma VM Linux na Azure

Neste guia, vou dividir o script Terraform em blocos com explicações.

## 1. **Definição do Grupo de Recursos**

```hcl
data "azurerm_resource_group" "res-2" {
  name = var.resource_group_name
}
```

- **Descrição**: Este bloco define um **grupo de recursos** no Azure.
- **Responsabilidade**: O grupo de recursos é usado para organizar e gerenciar recursos relacionados. Ele agrupa recursos que compartilham o mesmo ciclo de vida, permissões e políticas.
- **Detalhes**:
    - O nome do grupo de recursos é obtido da variável `var.resource_group_name`.

## 2. **Acesso ao Azure Key Vault**

```hcl
data "azurerm_key_vault" "kv-infraestrutura" {
  name                = var.kv_name
  resource_group_name = var.kv_resource_group_name
}
```

- **Descrição**: Este bloco obtém informações de um **Azure Key Vault**.
- **Responsabilidade**: O Azure Key Vault é usado para armazenar e gerenciar segredos, chaves e certificados.
- **Detalhes**:
    - O nome do Key Vault é obtido da variável `var.kv_name`.
    - O grupo de recursos associado ao Key Vault é obtido da variável `var.kv_resource_group_name`.

## 3. **Chave Pública SSH do Key Vault**

```hcl
data "azurerm_key_vault_secret" "SSHPublicKey" {
  name         = var.sshsecretname
  key_vault_id = data.azurerm_key_vault.kv-infraestrutura.id
}
```

- **Descrição**: Este bloco obtém a **chave pública SSH** armazenada no Key Vault.
- **Responsabilidade**: A chave pública SSH será usada para autenticar na VM Linux.
- **Detalhes**:
    - O nome do segredo (chave pública SSH) é obtido da variável `var.sshsecretname`.
    - O ID do Key Vault é obtido do bloco anterior.

## 4. **Configuração da VM Linux**

```hcl
resource "azurerm_linux_virtual_machine" "res-1" {
  # Configurações da VM...
}
```

- **Descrição**: Este bloco cria uma **máquina virtual Linux** na Azure.
- **Responsabilidade**: A VM Linux será provisionada com as configurações especificadas.
- **Detalhes**:
    - Nome de usuário do administrador: `var.admin_username`
    - Localização: obtida do grupo de recursos
    - Nome da VM: `var.vm_name`
    - Chave pública SSH: obtida do Key Vault
    - Tamanho da VM: `var.vm_size`
    - Imagem do sistema operacional: Ubuntu 20.04 LTS

## 5. **Interface de Rede da VM**

```hcl
resource "azurerm_network_interface" "res-0" {
  # Configurações da interface de rede...
}
```

- **Descrição**: Este bloco cria uma **interface de rede** para a VM.
- **Responsabilidade**: A interface de rede conecta a VM à rede virtual.
- **Detalhes**:
    - Localização: obtida do grupo de recursos
    - Nome da interface: gerado aleatoriamente
    - Dependência: aguarda a criação da interface de rede antes de criar a VM

Lembre-se de preencher as variáveis (`var.resource_group_name`, `var.kv_name`, etc.) com os valores apropriados antes de executar o Terraform.