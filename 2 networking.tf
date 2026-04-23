# 3. Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "employee-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 4. Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "employee-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 5. Public IP (Standard & Static)
resource "azurerm_public_ip" "public_ip" {
  name                = "employee-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  allocation_method   = "Static"
}
