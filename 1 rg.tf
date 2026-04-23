# 2. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "employee-app-rg1"
  location = "central india"
}