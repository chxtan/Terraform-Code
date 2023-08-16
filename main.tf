terraform {    
  required_providers {    
    azurerm = {    
      source = "hashicorp/azurerm"    
    }
  }
  backend "azurerm" {
    resource_group_name  = "task-chetan"
    storage_account_name = "terraformchxtan"
    container_name       = "chxtan"
    key                  = "deploy.tfstate"
  }
} 
   
provider "azurerm" {
  client_id = "<YOUR CLIENT ID HERE"
  client_secret = "YOUR CLIENT PASSWORD HERE"
  tenant_id = "YOUR TENANT ID HERE"
  subscription_id = "YOUR SUBSCRIPTION ID HERE"
  features {}    
}

resource "azurerm_resource_group" "resource_group" {
  name     = "app-service-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "myappservice-plan"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "mywebapp-chetan"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  https_only              = true

  site_config {
    always_on                 = true
    dotnet_framework_version  = "v2.0"
    windows_fx_version        = "Dotnet|v7.0"
  }
}

