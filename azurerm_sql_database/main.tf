resource "azurerm_sql_database" "example" {
  name                = var.mssql_database_name
  resource_group_name = var.rg_name
  location            = var.location
  server_name         = var.sqlserver_name
}