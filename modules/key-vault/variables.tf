variable "region" {
    type = string
    description = "location"    
}

variable "rgname" {
    type = string
    description = "rgname"    
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

variable "webappid" {
    type = string
    description = "webappid"    
}

variable "functionappid" {
    type = string
    description = "functionappid"    
}