resource "azurerm_storage_account" "storageacc" {
  name                     = var.storagename
  resource_group_name      = var.rgname
  location                 = var.region
  account_tier             = var.storagesku
  account_replication_type = var.storageredundancy
}

output "storagename" {
  value = azurerm_storage_account.storageacc.name
}

output "storageaccesskey" {
  value = azurerm_storage_account.storageacc.primary_access_key
}