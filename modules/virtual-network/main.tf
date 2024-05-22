resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsgname
  location            = var.region
  resource_group_name = var.rgname
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnetname
  location            = var.region
  resource_group_name = var.rgname
  address_space       = var.vnet1addressspace
}

resource "azurerm_subnet" "subnet1" {
  name = var.subnet1name
  resource_group_name = var.rgname
  address_prefixes = var.subnet1addressspace
  virtual_network_name = azurerm_virtual_network.vnet1.name

  service_endpoints = [ 
                        "Microsoft.Sql",
                        "Microsoft.Web"
                      ]

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet1nsg" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

output "vnet1" {
  value = azurerm_virtual_network.vnet1.id
}

output "subnet1" {
  value = azurerm_subnet.subnet1.id
}