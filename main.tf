terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "aiops_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure OpenAI Cognitive Account
resource "azurerm_cognitive_account" "openai" {
  name                = var.openai_account_name
  location            = azurerm_resource_group.aiops_rg.location
  resource_group_name = azurerm_resource_group.aiops_rg.name
  kind                = "OpenAI"
  sku_name            = "S0"
}

# GPT-4 deployment 
resource "azurerm_cognitive_deployment" "gpt4_deployment" {
  name                 = "gpt-4"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo"
    version = "0613"
  }

  scale {
    type     = "Standard"
    capacity = 10
  }
}

A
A
A
A
A
A
A
A
A
A

