#Terraform #Azure #Cloud
```hcl
variable "admin_username" {
  type        = string
  default = "recadmin" // Nome de usuário do administrador da VM
}

variable "vm_size" {
  type        = string
  default = "Standard_B4ms" // Tamanho da VM que será criada (disco usado na VM)
}

variable "storage_account_type" {
  type        = string
  default = "StandardSSD_LRS" // Tipo de conta de armazenamento para os discos
}

variable "private_ip_address_allocation" {
  type        = string
  default = "Dynamic" // Alocação de endereço IP privado (Dynamic ou Static)
}

variable "passwordserveradmin" {
  type        = string
  default = "PasswordServerAdmin" // Senha para o administrador do servidor
}

variable "dns_servers" {
  type        = list(string)
  default     = [
    "xxx",
    "xxx"
  ] // Servidores DNS a serem usados pela VM
}
```

---
# Documentação das Variáveis de Configuração

Este documento descreve as variáveis de configuração usadas no código Terraform para provisionar recursos no Azure. Essas variáveis são usadas para personalizar e parametrizar a implantação de recursos. Abaixo estão detalhadas cada uma das variáveis:

## `admin_username`

```hcl
variable "admin_username" {
  type        = string
  default     = "recadmin" // Nome de usuário do administrador da VM
}
```

Esta variável define o nome de usuário do administrador da máquina virtual (VM). O valor padrão é "recadmin". Você pode alterá-lo conforme necessário para definir o nome de usuário desejado para o administrador da VM.

## `vm_size`

```hcl
variable "vm_size" {
  type        = string
  default     = "Standard_B4ms" // Tamanho da VM que será criada (disco usado na VM)
}
```

Esta variável define o tamanho da máquina virtual (VM) que será criada. O valor padrão é "Standard_B4ms". Você pode modificar este valor para escolher o tamanho da VM apropriado de acordo com os requisitos do seu projeto.

## `storage_account_type`

```hcl
variable "storage_account_type" {
  type        = string
  default     = "StandardSSD_LRS" // Tipo de conta de armazenamento para os discos
}
```

Esta variável define o tipo de conta de armazenamento a ser usado para os discos associados à VM. O valor padrão é "StandardSSD_LRS". Você pode alterar esse valor para selecionar o tipo de conta de armazenamento desejado.

## `private_ip_address_allocation`

```hcl
variable "private_ip_address_allocation" {
  type        = string
  default     = "Dynamic" // Alocação de endereço IP privado (Dynamic ou Static)
}
```

Esta variável define o método de alocação de endereço IP privado para a VM. O valor padrão é "Dynamic", o que significa que os endereços IP são alocados dinamicamente. Você pode alterá-lo para "Static" se desejar endereços IP estáticos.

## `passwordserveradmin`

```hcl
variable "passwordserveradmin" {
  type        = string
  default     = "PasswordServerAdmin" // Senha para o administrador do servidor
}
```

Esta variável define a senha para o administrador do servidor, que será usada ao provisionar a VM. O valor padrão é "PasswordServerAdmin". Certifique-se de definir uma senha segura quando configurar sua implantação.

## `dns_servers`

```hcl
variable "dns_servers" {
  type        = list(string)
  default     = [
    "xxx",
    "xxx"
  ] // Servidores DNS a serem usados pela VM
}
```

Esta variável define uma lista de servidores DNS a serem usados pela VM. Os valores padrão são placeholders ("xxx"). Substitua esses valores pelos servidores DNS apropriados que sua VM deve usar.

Estas variáveis de configuração são essenciais para personalizar sua implantação no Azure usando Terraform. Certifique-se de ajustar esses valores de acordo com os requisitos específicos do seu projeto antes de realizar a implantação.

Esta documentação em Markdown deve ajudá-lo a entender o propósito e a configuração das variáveis no código Terraform. Certifique-se de ajustar as variáveis conforme necessário para atender às necessidades do seu ambiente.