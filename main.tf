module "rg" {
  source = "./modules/resource-group"
  region = var.region
  rgname = var.rgname
}

module "storageaccount" {
  source = "./modules/storage-account"
  region = module.rg.location
  rgname = module.rg.rgname
  storagename = var.storagename
  storagesku = var.storagesku
  storageredundancy = var.storageredundancy
}

module "vnet" {
  source = "./modules/virtual-network"
  region = module.rg.location
  rgname = module.rg.rgname
  vnetname = var.vnetname
  subnet1name = var.subnet1name
  nsgname = var.nsgname
  vnet1addressspace = var.vnet1addressspace
  subnet1addressspace = var.subnet1addressspace
}

module "monitoring" {
  source = "./modules/monitoring"
  region = module.rg.location
  rgname = module.rg.rgname
  appinsightsname = var.appinsightsname
}

module "webapp" {
  source = "./modules/web-app"
  region = module.rg.location
  rgname = module.rg.rgname
  aspos = var.aspos
  aspname = var.aspname
  aspsku = var.aspsku
  aspsize = var.aspsize
  webappname = var.webappname
  functionappname = var.functionappname
  appinsightsname = var.appinsightsname
  storagename = module.storageaccount.storagename
  storageaccountaccesskey = module.storageaccount.storageaccesskey
  appinsightsinstrumentationkey = module.monitoring.appinsightsinstrumentationkey
  appinsightsconnectionstring = module.monitoring.appinsightsconnectionstring
  subnetid = module.vnet.subnet1
}

module "keyvault" {
  source = "./modules/key-vault"
  region = module.rg.location
  rgname = module.rg.rgname
  keyvaultname = var.keyvaultname
  keyvaultsku = var.keyvaultsku
  webappid = module.webapp.webappid
  functionappid = module.webapp.functionappid
  keyvaultpurgeprotection = var.keyvaultpurgeprotection
}

module "sqlserver" {
  source = "./modules/sql-server"
  region = module.rg.location
  rgname = module.rg.rgname
  sqlservername = var.sqlservername
  sqlusername = module.keyvault.sql-username
  sqlpassword = module.keyvault.sql-password
  sqlep1name = var.sqlep1name
  sqldbname = var.sqldbname
  sqlskuname = var.sqlskuname
  sqltier = var.sqltier
  sqldbcount = var.sqldbcount
  subnetid = module.vnet.subnet1
}