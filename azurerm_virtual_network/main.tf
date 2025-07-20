resource "azurerm_virtual_network" "Vnet" {
    name = var.virtual_network_name
    resource_group_name = var.resource_group_name
    location = var.location
    address_space = var.address_space
    
}