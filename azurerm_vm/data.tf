data "frontend_public_ip" "pip1" {
  name                = var.public_frontend_ip
  resource_group_name = var.resource_group_name
}
data "backend_public_ip" "pip2" {
  name                = var.public_backend_ip
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "frontend_subnet" {
  name                 = var.frontend_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_subnet" "backend_subnet" {
  name                 = var.backend_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

