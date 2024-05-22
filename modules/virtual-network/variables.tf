variable "nsgname" {
    type = string
    description = "nsgname"    
}

variable "region" {
    type = string
    description = "location"    
}

variable "rgname" {
    type = string
    description = "rgname"    
}

variable "vnetname" {
    type = string
    description = "vnetname"    
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