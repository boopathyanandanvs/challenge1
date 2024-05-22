resource "azurerm_mssql_server" "sqlserver1" {
  name                         = var.sqlservername
  resource_group_name          = var.rgname
  location                     = var.region
  version                      = "12.0"
  administrator_login          = var.sqlusername
  administrator_login_password = var.sqlpassword
  minimum_tls_version          = "1.2"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_virtual_network_rule" "sqlvnetrule" {
  name      = "sql-vnet-rule"
  server_id = azurerm_mssql_server.sqlserver1.id
  subnet_id = var.subnetid
}

resource "azurerm_mssql_elasticpool" "sqlep1" {
  name                = var.sqlep1name
  resource_group_name = var.rgname
  location            = var.region
  server_name         = azurerm_mssql_server.sqlserver1.name
  license_type        = "LicenseIncluded"
  max_size_gb         = 100

  sku {
    name     = var.sqlskuname
    tier     = var.sqltier
    capacity = 50
  }

  per_database_settings {
    min_capacity = 0
    max_capacity = 50
  }
}

resource "azurerm_mssql_database" "sqldbs" {

  count         = var.sqldbcount

  name           = "${var.sqldbname}-${count.index}"
  server_id      = azurerm_mssql_server.sqlserver1.id
  elastic_pool_id = azurerm_mssql_elasticpool.sqlep1.id
  max_size_gb    = 2
  zone_redundant = false

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}