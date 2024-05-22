variable "rgname" {
    type = string
    description = "rgname"    
}

variable "region" {
    type = string
    description = "azure deployment region"    
}

#vnet
variable "vnetname" {
    type = string
    description = "vnet name"    
}

variable "nsgname" {
    type = string
    description = "nsg name"    
}

variable "subnet1name" {
    type = string
    description = "subnet1name"    
}

variable "vnet1addressspace" {
    type = list
    description = "vnet1addressspace"    
}

variable "subnet1addressspace" {
    type = list
    description = "subnet1addressspace"    
}

#asp
variable "aspos" {
    type = string
    description = "aspos"    
}

variable "aspname" {
    type = string
    description = "aspname"    
}

variable "aspsku" {
    type = string
    description = "aspsku"    
}

variable "aspsize" {
    type = string
    description = "aspsize"    
}

variable "webappname" {
    type = string
    description = "webappname"    
}

variable "functionappname" {
    type = string
    description = "functionappname"    
}

variable "appinsightsname" {
    type = string
    description = "appinsightsname"    
}

variable "storagename" {
    type = string
    description = "storagename"    
}

variable "storagesku" {
    type = string
    description = "storagesku"    
}

variable "storageredundancy" {
    type = string
    description = "storageredundancy"    
}

variable "keyvaultname" {
    type = string
    description = "keyvaultname"    
}

variable "keyvaultsku" {
    type = string
    description = "keyvaultsku"    
}

variable "keyvaultpurgeprotection" {
    type = bool
    description = "keyvaultpurgeprotection"    
}

variable "sqlservername" {
    type = string
    description = "sqlservername"    
}

variable "sqlskuname" {
    type = string
    description = "sqlskuname"    
}

variable "sqltier" {
    type = string
    description = "sqltier"    
}

variable "sqlep1name" {
    type = string
    description = "sqlep1name"    
}

variable "sqldbcount" {
    type = number
    description = "sqldbcount"    
}

variable "sqldbname" {
    type = string
    description = "sqldbname"    
}