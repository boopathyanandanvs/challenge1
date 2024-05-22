data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault1" {
  name                        = var.keyvaultname
  location                    = var.region
  resource_group_name         = var.rgname
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = var.keyvaultpurgeprotection

  sku_name = var.keyvaultsku

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Update", "Delete", "Create"
    ]

    secret_permissions = [
      "Get", "List", "Delete", "Set", "Recover"
    ]

    certificate_permissions = [
      "Get", "List", "Update", "Delete", "Create"
    ]
  }

  lifecycle {
    ignore_changes = [
      access_policy
    ]
  }
}

resource "azurerm_key_vault_access_policy" "webapppolicy" {
  key_vault_id = azurerm_key_vault.keyvault1.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.webappid

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get", "List"   
  ]

  certificate_permissions = [
    "Get", "List"
  ]
}

resource "azurerm_key_vault_access_policy" "fnapppolicy" {
  key_vault_id = azurerm_key_vault.keyvault1.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.functionappid

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get", "List"   
  ]

  certificate_permissions = [
    "Get", "List"
  ]
}

resource "random_password" "sqlusername" {
  length           = 6
  special          = false
  numeric           = false
}

resource "random_password" "sqlpasswordgenerator" {
  length           = 16
  special          = true
}

resource "azurerm_key_vault_secret" "sqluser" {
  name         = "sql-user"
  value        = random_password.sqlusername.result
  key_vault_id = azurerm_key_vault.keyvault1.id
}

resource "azurerm_key_vault_secret" "sqlpassword" {
  name         = "sql-password"
  value        = random_password.sqlpasswordgenerator.result
  key_vault_id = azurerm_key_vault.keyvault1.id
}

output "sql-username" {
  sensitive = true
  value = azurerm_key_vault_secret.sqluser.value
}

output "sql-password" {
  sensitive = true
  value = azurerm_key_vault_secret.sqlpassword.value
}