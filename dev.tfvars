rgname = "dev-rg"
region = "eastus"

#vnet
vnetname = "dev-vnet"
vnet1addressspace = ["10.0.0.0/16"]

#nsg
nsgname = "dev-nsg"

#subnet
subnet1addressspace = ["10.0.1.0/27"]
subnet1name = "dev-subnet01"

#asp
aspos = "Linux"
aspname = "dev-asp"
aspsku = "Basic"
aspsize = "B1"

#webapp
webappname = "devwebappunique01"
functionappname = "devfunctionappunique01"

#appinsights
appinsightsname = "dev-appinsights"

#storage
storagename = "devstorageappunique01"
storagesku = "Standard"
storageredundancy = "LRS"

#key vault
keyvaultname = "devkeyvaultunique01"
keyvaultsku = "standard"
keyvaultpurgeprotection = false

#sqlserver
sqlservername = "devsqlserverunique01"
sqlep1name = "sqlep01"
sqlskuname = "StandardPool"
sqltier = "Standard"
sqldbname = "sqldb"
sqldbcount = 5