terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Ikkada kothaga Backend block pedutunnam
  backend "azurerm" {
    resource_group_name  = "tfstate-rgg"            # Nuvvu create chesina RG name
    storage_account_name = "yashtfstate3249"   # Nuvvu pettina unique storage name
    container_name       = "tfstate"
    key                  = "terraform.tfstate"     # Ee peru thone file save avtundi
  }
}

provider "azurerm" {
  features {}
}
