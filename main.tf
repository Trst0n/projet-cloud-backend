provider "azurerm" {
  features {}
  subscription_id = "2e440b03-68c2-42d1-bb9b-0128d9d07f1e"
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "back" {
  name     = "projet-cloud"
  location = "West Europe"
}

resource "azurerm_service_plan" "back" {
  name                = "backendprojet-service"
  resource_group_name = azurerm_resource_group.back.name
  location            = azurerm_resource_group.back.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "back" {
  name                = "backendprojet-app"
  resource_group_name = azurerm_resource_group.back.name
  location            = azurerm_service_plan.back.location
  service_plan_id     = azurerm_service_plan.back.id

  site_config {
   application_stack {
      docker_image_name   = "projetCloud.azurecr.io/myapp:latest"
      docker_registry_url = "https://projetCloud.azurecr.io"
      docker_registry_username = "projetCloud"
      docker_registry_password = "qj5K3ZyddS/gRQXGe2s9AcTmPQ29IOogdleE21Jr5S+ACRAx3+Ci"
    }
  }
}
