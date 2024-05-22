resource "azurerm_application_insights" "appinsights" {
  name                = var.appinsightsname
  location            = var.region
  resource_group_name = var.rgname
  application_type    = "web"
}

output "appinsightsinstrumentationkey" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}

output "appinsightsconnectionstring" {
  value = azurerm_application_insights.appinsights.connection_string
}