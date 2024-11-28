provider "azurerm" {
  features {}
  subscription_id = "581196dc-2cdf-42b4-81c7-4dae758431a0"
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "back" {
  name     = "projet-cloud"
  location = "Europe West"
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
    linux_fx_version = "DOCKER|projetcloud.azurecr.io/myapp:latest"  # Remplacez par le nom exact de votre image dans l'ACR
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL" = "https://projetcloud.azurecr.io"  # URL de votre ACR
    "DOCKER_REGISTRY_SERVER_USERNAME" =  "projetCloud" # Remplacez par votre identifiant ACR
    "DOCKER_REGISTRY_SERVER_PASSWORD" = "qj5K3ZyddS/gRQXGe2s9AcTmPQ29IOogdleE21Jr5S+ACRAx3+Ci"  # Remplacez par votre mot de passe ACR
  }
}
