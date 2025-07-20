module "resource_group" {
  source = "../azurerm_resource_group"
  resource_group_name = "todo-rg"
  location = "West US"
} 
module "azurerm_virtual_network" {
  depends_on = [module.resource_group]
source = "../azurerm_virtual_network"
name = "TodoVnet"
resource_group_name = "todo-rg"
location = "West US"
address_space = ["10.0.0.0/16"]
}
module "azurerm_subnet" {
  depends_on = [module.resource_group , module.virtual_network]
  source = "../azurerm_subnet"
  name = "forntendsubnet"
  resource_group_name = "todo-rg"
  virtual_network_name = "TodoVnet"
  address_prefixes = ["10.0.1.0/24"]

}
module "azurerm_subnet" {
  depends_on = [module.resource_group , module.virtual_network]
  source = "../azurerm_subnet"
  name = "backendsubnet"
  resource_group_name = "todo-rg"
  virtual_network_name = "TodoVnet"
  address_prefixes = ["10.0.2.0/24"]
  
}
module "public_ip" {
  depends_on = [module.resource_group]
 source = "../azurerm_public_ip"
 name = "frontendpip"
 resource_group_name = "todo-rg"
 location = "West US"
 allocation_method = "Dynamic"
}
module "public_ip" {
  depends_on = [module.resource_group]
 source = "../azurerm_public_ip"
 name = "backendpip"
 resource_group_name = "todo-rg"
 location = "West US"
 allocation_method = "Dynamic"
}
module "azurerm_mssql_server" {
  depends_on = [module.resource_group]

source = "../azurerm_sql_server"
name = "todosqlserver"
resource_group_name = "todo-rg"
location = "West US"
administrator_login = "brijednra"
administraotr_login_password = "Diwali@2025"

}
module "azurerm_smsql_database" {

  source = "../azurerm_slq_database"
  name = "Todosqldatabase"
  resource_group_name = "todo-rg"
  location = "West US"
  server_name = "todosqlserver"

}
module "azurerm_frontend_VM" {
  source = "../azurerm_vm"
  nic_name = "todoforntendnic" 
  resource_group_name = "todo-rg"
  location = "West US"
  vm_name = "frontend_vm"
  vm_size = "Standard_B1s"
  admin_username = "brijedrakumar"
  admin_password = "Apple@123456"
  image_publisher = "canonical"
  image_offer = "0001-com-ubuntu-server-focal"
  image_sku = "20_04-lts"
  image_version = "latest"
  

}
module "azurerm_backend_VM" {
  source = "../azurerm_vm"
  nic_name = "forntendnic" 
  resource_group_name = "todo-rg"
  location = "West US"
  vm_name = "frontend_vm"
  vm_size = "Standard_B1s"
  admin_username = "brijedrakumar"
  admin_password = "Apple@123456"
  image_publisher = "canonical"
  image_offer = "0001-com-ubuntu-server-focal"
  image_sku = "20_04-lts"
  image_version = "latest"
  

}
module "key_vault" {
  source              = "../modules/azurerm_key_vault"
  key_vault_name      = "sonamkitijori"
  location            = "centralindia"
  resource_group_name = "rg-todoapp"
}

module "vm_password" {
  source              = "../modules/azurerm_key_vault_secret"
  depends_on          = [module.key_vault]
  key_vault_name      = "sonamkitijori"
  resource_group_name = "rg-todoapp"
  secret_name         = "vm-password"
  secret_value        = "P@ssw01rd@123"
}

module "vm_username" {
  source              = "../modules/azurerm_key_vault_secret"
  depends_on          = [module.key_vault]
  key_vault_name      = "sonamkitijori"
  resource_group_name = "rg-todoapp"
  secret_name         = "vm-username"
  secret_value        = "devopsadmin"
}





