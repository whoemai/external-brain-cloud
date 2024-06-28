variable "resourcegroup" {
    type        = string
    default     = ""
}

variable "location" {
    type        = string
    default     = ""
}

variable "locationshort" {
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

variable "component" {
    type        = string
    default     = ""
}

variable "addr_space" {
    type        = list
    default     = [""]
}