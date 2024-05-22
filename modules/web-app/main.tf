resource "azurerm_service_plan" "appserviceplan1" {
  name                = var.aspname
  resource_group_name = var.rgname
  location            = var.region
  os_type             = var.aspos
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "webapp1" {
  name                = var.webappname
  location            = var.region
  resource_group_name = var.rgname
  service_plan_id = azurerm_service_plan.appserviceplan1.id

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY =  var.appinsightsinstrumentationkey
    APPLICATIONINSIGHTS_CONNECTION_STRING =  var.appinsightsconnectionstring
    ApplicationInsightsAgent_EXTENSION_VERSION = "~4"
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
    always_on = true
  }
}

resource "azurerm_linux_function_app" "functionapp1" {
  name                = var.functionappname
  resource_group_name = var.rgname
  location            = var.region

  storage_account_name       = var.storagename
  storage_account_access_key = var.storageaccountaccesskey
  service_plan_id            = azurerm_service_plan.appserviceplan1.id

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    ApplicationInsightsAgent_EXTENSION_VERSION = "~4"
  }

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
    always_on = true
    application_insights_key = var.appinsightsinstrumentationkey
    application_insights_connection_string = var.appinsightsconnectionstring
    vnet_route_all_enabled = true
  }

  lifecycle {
    ignore_changes = [
      virtual_network_subnet_id
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "functionappvnetintegration" {
  app_service_id = azurerm_linux_function_app.functionapp1.id
  subnet_id      = var.subnetid
}

output "aspid" {
  value = azurerm_service_plan.appserviceplan1.id
}

output "webappid" {
  value = azurerm_linux_web_app.webapp1.identity[0].principal_id
}

output "functionappid" {
  value = azurerm_linux_function_app.functionapp1.identity[0].principal_id
}
