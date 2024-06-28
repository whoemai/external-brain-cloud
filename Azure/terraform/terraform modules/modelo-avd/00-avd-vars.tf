variable "suffix" {
    default = "avd"
}

variable "location" {
    default = "Brazil South"
}

variable "vnet" {
    default = "10.0.0.0/24"
}

variable "snet" {
    default = "10.0.0.0/24"
}

variable "vmcount" {
    default = 1
}

variable "vmsize" {
    default = "Standard_D4as_v4"
}

variable "localusername" {
    default = "localadmin"
}

variable "localpassword" {
    default = "P@ssw0rd"
}

variable "img_publisher" {
    default = "MicrosoftWindowsDesktop"
}

variable "img_offer" {
    default = "windows-11"
}

variable "img_sku" {
    default = "win11-21h2-avd"
}

variable "img_version" {
    default = "latest"
}

variable "domain_dnsname" {
    default = "dominio.local"
}

variable "domain_oupath" {
    default = "OU=Servers,DC=dominio,DC=local"
}

variable "domain_joinuser" {
    default = "usuarioadm@dominio.local"
}

variable "domain_joinuserpassword" {
    default = "P@ssw0rd"
}

variable "artifactslocation" {
    description = "Location of AVD Artifacts"
    default = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration.zip"
}
