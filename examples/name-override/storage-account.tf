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
##  examples/name-override/storage-account.tf
##
##  Creates a resource group and a private storage account whose name is set exactly with
##  name_override. Every input is listed; null leaves an argument unset. The _outputs.tf file
##  asserts the resulting name.
## ----------------------------------------------------------------------------

## Resource Group
resource "azurerm_resource_group" "this" {
  location = var.region
  name     = "${module.context.id}-rg"
  tags     = module.context.tags
}


## Storage Account
module "storage_account" {
  source  = "../../"
  context = module.context.self

  # An exact name chosen by the caller: 3 to 24 lowercase letters and digits. The context and
  # attributes are not used for the account name when name_override is set.
  name_override = "rgnameoverrideexample"

  access_tier                       = null
  account_kind                      = null
  account_replication_type          = "LRS"
  account_tier                      = "Standard"
  allow_nested_items_to_be_public   = false
  allowed_copy_scope                = null
  cross_tenant_replication_enabled  = null
  default_to_oauth_authentication   = null
  dns_endpoint_type                 = null
  edge_zone                         = null
  https_traffic_only_enabled        = null
  infrastructure_encryption_enabled = null
  is_hns_enabled                    = null
  large_file_share_enabled          = null
  local_user_enabled                = null
  location                          = azurerm_resource_group.this.location
  min_tls_version                   = "TLS1_2"
  nfsv3_enabled                     = null
  provisioned_billing_model_version = null
  public_network_access_enabled     = false
  queue_encryption_key_type         = null
  resource_group_name               = azurerm_resource_group.this.name
  sftp_enabled                      = null
  shared_access_key_enabled         = false
  table_encryption_key_type         = null

  azure_files_authentication = null
  blob_properties            = null
  custom_domain              = null
  customer_managed_key       = null
  identity                   = null
  immutability_policy        = null
  network_rules              = null
  queue_properties           = null
  routing                    = null
  sas_policy                 = null
  share_properties           = null
  static_website             = null
  timeouts                   = null
}
