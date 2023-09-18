#Cloud #Azure #Terraform 

```hcl
variable "admin_username" {
  type    = string
  default = "xxx"
}

variable "vm_size" {
  type    = string
  default = "Standard_B4ms"
}

variable "storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

variable "sshsecretname" {
  type    = string
  default = "SSHPublicKey"
}

variable "dns_servers" {
  type    = list(string)
  default = ["10.170.1.164","10.170.1.165","10.170.1.166","10.170.1.167","10.160.1.167"]
}

variable "resource_group_name" {
  type = string
}
variable "kv_name" {
  type = string
}
variable "kv_resource_group_name" {
  type = string
}
variable "vm_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
```