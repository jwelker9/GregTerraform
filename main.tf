# Configure the Azure provider
terraform {

  backend "azurerm" {
    use_azuread_auth     = true
    tenant_id            = "4d01840f-29aa-41aa-846d-380b56fdaffb"
    client_id            = "4e550935-b239-479e-affe-257436de921e"
    client_secret        = "XXXXX"
    storage_account_name = "terraformstatejohnny"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }





  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.3.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westus2"

  tags = {
    Environment = "Terraform Getting Started"
    Team        = "CloudID"
  }
}

provider "azuread" {
}

resource "azuread_conditional_access_policy" "ADE_Whiteboard_Kiosks" {
  display_name = "ADE Whiteboard Kiosks-BacktoBasicsWithSP"
  state        = "disabled"

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_users  = []
      excluded_users  = var.ca_ga_account_wmtlabs
      included_groups = ["8290fdac-81b2-4cf5-be11-3e4bf1cfc4eb"] #Replaced with random, related guids from wmtlabs
      excluded_groups = []
      included_roles  = []
      excluded_roles  = ["62e90394-69f5-4237-9190-012177145e10"] #Global ID for GA
    }

    locations {
      included_locations = ["All"]
      excluded_locations = []
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["domainJoinedDevice"]
  }
}
