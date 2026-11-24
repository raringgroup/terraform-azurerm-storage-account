## ----------------------------------------------------------------------------
## Copyright 2026 Raring Group LLC
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
## ----------------------------------------------------------------------------
##
##  modules/storage-account/_outputs.tf
##
##  Output values for the storage-account module. Access keys and connection
##  strings are never output.
## ----------------------------------------------------------------------------

output "customer_managed_key" {
  description = "Customer managed key of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].customer_managed_key, null)
}

output "id" {
  description = "Id of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].id, null)
}

output "identity" {
  description = "Identity of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].identity, null)
}

output "name" {
  description = "Name of the storage account: name_override when set, otherwise the name generated from the context (null when disabled)"
  value       = try(azurerm_storage_account.this[0].name, null)
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_blob_endpoint, null)
}

output "primary_blob_host" {
  description = "Primary blob host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_blob_host, null)
}

output "primary_dfs_endpoint" {
  description = "Primary dfs endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_dfs_endpoint, null)
}

output "primary_dfs_host" {
  description = "Primary dfs host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_dfs_host, null)
}

output "primary_file_endpoint" {
  description = "Primary file endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_file_endpoint, null)
}

output "primary_file_host" {
  description = "Primary file host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_file_host, null)
}

output "primary_location" {
  description = "Primary location of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_location, null)
}

output "primary_queue_endpoint" {
  description = "Primary queue endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_queue_endpoint, null)
}

output "primary_queue_host" {
  description = "Primary queue host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_queue_host, null)
}

output "primary_table_endpoint" {
  description = "Primary table endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_table_endpoint, null)
}

output "primary_table_host" {
  description = "Primary table host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_table_host, null)
}

output "primary_web_endpoint" {
  description = "Primary web endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_web_endpoint, null)
}

output "primary_web_host" {
  description = "Primary web host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].primary_web_host, null)
}

output "secondary_blob_endpoint" {
  description = "Secondary blob endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_blob_endpoint, null)
}

output "secondary_blob_host" {
  description = "Secondary blob host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_blob_host, null)
}

output "secondary_dfs_endpoint" {
  description = "Secondary dfs endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_dfs_endpoint, null)
}

output "secondary_dfs_host" {
  description = "Secondary dfs host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_dfs_host, null)
}

output "secondary_file_endpoint" {
  description = "Secondary file endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_file_endpoint, null)
}

output "secondary_file_host" {
  description = "Secondary file host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_file_host, null)
}

output "secondary_location" {
  description = "Secondary location of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_location, null)
}

output "secondary_queue_endpoint" {
  description = "Secondary queue endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_queue_endpoint, null)
}

output "secondary_queue_host" {
  description = "Secondary queue host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_queue_host, null)
}

output "secondary_table_endpoint" {
  description = "Secondary table endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_table_endpoint, null)
}

output "secondary_table_host" {
  description = "Secondary table host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_table_host, null)
}

output "secondary_web_endpoint" {
  description = "Secondary web endpoint of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_web_endpoint, null)
}

output "secondary_web_host" {
  description = "Secondary web host of the storage account (null when disabled)"
  value       = try(azurerm_storage_account.this[0].secondary_web_host, null)
}
