resource "azurerm_resource_group" "test-rg" {
  name     = var.rgname
  location = var.region
}

output "rgname" {
  value = azurerm_resource_group.test-rg.name
}

output "location" {
  value = azurerm_resource_group.test-rg.location
}