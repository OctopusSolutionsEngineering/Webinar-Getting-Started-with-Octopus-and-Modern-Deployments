terraform {
  backend "azurerm" {
    resource_group_name  = "demo.octopus.app"
    storage_account_name = "octodemotfstate"
    container_name       = "terraform-state"
    key                  = "Webinar-RandomQuotes-#{Octopus.Environment.Name}.terraform.tfstate"
  }
}

provider "azurerm" {
   features {}
}

variable "resourcegroupname" {
  type = "string"
  default = "demo.octopus.app"
}

variable "webappname" {
  type = "string"
  default = "Webinar-RandomQuotes-#{Octopus.Environment.Name}"
}

variable "environment" {
  type = "string"
  default = "#{Octopus.Environment.Name}"
}

variable "location" {
  type = "string"
  default = "south central us"
}

variable "region" {
  type = "string"
  default = "southcentralus"
}

variable "owner" {
  type = "string"
  default = "Webinar-RandomQuotes-#{Octopus.Environment.Name}"
}

variable "description" {
  type = "string"
  default = "RandomQuotes Website"
}

resource "azurerm_app_service_plan" "main" {
  name = "${var.webappname}-service-plan"
  location = "${var.location}"
  resource_group_name = "${var.resourcegroupname}"
  kind = "Linux"
  reserved = true

  sku {
    tier = "Basic"
    size = "B1"
  }

  tags = {
    description = "${var.description}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.webappname}"
  location = "${var.location}"
  resource_group_name = "${var.resourcegroupname}"
  app_service_plan_id = "${azurerm_app_service_plan.main.id}"

  site_config {
    linux_fx_version = "DOTNETCORE|3.1"
  }

  tags = {
    description = "${var.description}"
    environment = "${var.environment}"
    owner       = "${var.owner}"
    octopus-environment = "#{Octopus.Environment.Name}"
    octopus-role = "random-quotes-web"
  }
}
