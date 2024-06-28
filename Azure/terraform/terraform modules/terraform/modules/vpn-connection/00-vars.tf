variable "resourcegroup" {
    type        = string
    default     = ""
}

variable "vnet" {
    type        = string
    default     = ""
}

variable "location" {
    type        = string
    default     = ""
}

variable "env" {
    type        = string
    default     = ""
}

variable "customer" {
    type        = string
    default     = ""
}

variable "resource" {
    type        = string
    default     = ""
}

variable "addr_prefix" {
    type        = list
    default     = [""]
}