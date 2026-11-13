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
##  modules/storage-account/_variables.tf
##
##  Input variables for the storage-account module.
## ----------------------------------------------------------------------------

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot, Cool, Cold, Smart and Premium. Defaults to Hot."
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Possible values are LRS, GRS, RAGRS, ZRS, GZRS, and RAGZRS."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to false."
}

variable "allowed_copy_scope" {
  type        = string
  description = "The permitted scope for copy operations between storage accounts. Possible values are AAD, PrivateLink and All."
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  description = "Should cross Tenant replication be enabled? Defaults to false."
}

variable "default_to_oauth_authentication" {
  type        = bool
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false"
}

variable "dns_endpoint_type" {
  type        = string
  description = "Specifies which DNS endpoint type to use. Possible values are Standard and AzureDnsZone. Defaults to Standard. Changing this forces a new resource to be created."
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled. Defaults to true."
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
}

variable "is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created."
}

variable "large_file_share_enabled" {
  type        = bool
  description = "Are Large File Shares Enabled? Defaults to false."
}

variable "local_user_enabled" {
  type        = bool
  description = "Is Local User Enabled? Defaults to true."
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. The only possible value is TLS1_2. Defaults to TLS1_2 for new storage accounts."
}

variable "nfsv3_enabled" {
  type        = bool
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false."
}

variable "provisioned_billing_model_version" {
  type        = string
  description = "Specifies the version of the **provisioned** billing model (e.g. when account_kind = 'FileStorage' for Storage File). Possible value is V2. Changing this forces a new resource to be created."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether the public network access is enabled. Defaults to true."
}

variable "queue_encryption_key_type" {
  type        = string
  description = "The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
}

variable "sftp_enabled" {
  type        = bool
  description = "Boolean, enable SFTP for the storage account"
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active..."
}

variable "table_encryption_key_type" {
  type        = string
  description = "The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
}

variable "azure_files_authentication" {
  type = object({
    default_share_level_permission = optional(string)
    directory_type                 = string
    active_directory = optional(object({
      domain_guid         = string
      domain_name         = string
      domain_sid          = optional(string)
      forest_name         = optional(string)
      netbios_domain_name = optional(string)
      storage_sid         = optional(string)
    }))
  })
  description = "A azure_files_authentication block as defined below."
}

variable "blob_properties" {
  type = object({
    change_feed_enabled           = optional(bool)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool)
    versioning_enabled            = optional(bool)
    container_delete_retention_policy = optional(object({
      days = optional(number)
    }))
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    delete_retention_policy = optional(object({
      days                     = optional(number)
      permanent_delete_enabled = optional(bool)
    }))
    restore_policy = optional(object({
      days = number
    }))
  })
  description = "A blob_properties block as defined below."
}

variable "custom_domain" {
  type = object({
    name          = string
    use_subdomain = optional(bool)
  })
  description = "A custom_domain block as defined below."
}

variable "customer_managed_key" {
  type = object({
    key_vault_key_id          = optional(string)
    user_assigned_identity_id = string
  })
  description = "A customer_managed_key block as defined below."
}

variable "identity" {
  type = object({
    identity_ids = optional(set(string))
    type         = string
  })
  description = "An identity block as defined below."
}

variable "immutability_policy" {
  type = object({
    allow_protected_append_writes = bool
    period_since_creation_in_days = number
    state                         = string
  })
  description = "An immutability_policy block as defined below. Changing this forces a new resource to be created."
}

variable "network_rules" {
  type = object({
    bypass                     = optional(set(string))
    default_action             = string
    ip_rules                   = optional(set(string))
    virtual_network_subnet_ids = optional(set(string))
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
  })
  description = "A network_rules block as defined below."
}

variable "queue_properties" {
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    hour_metrics = optional(object({
      enabled               = bool
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
    logging = optional(object({
      delete                = bool
      read                  = bool
      retention_policy_days = optional(number)
      version               = string
      write                 = bool
    }))
    minute_metrics = optional(object({
      enabled               = bool
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
  })
  description = "The queue_properties block of azurerm_storage_account."
}

variable "routing" {
  type = object({
    choice                      = optional(string)
    publish_internet_endpoints  = optional(bool)
    publish_microsoft_endpoints = optional(bool)
  })
  description = "A routing block as defined below."
}

variable "sas_policy" {
  type = object({
    expiration_action = optional(string)
    expiration_period = string
  })
  description = "A sas_policy block as defined below."
}

variable "share_properties" {
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    retention_policy = optional(object({
      days = optional(number)
    }))
    smb = optional(object({
      authentication_types            = optional(set(string))
      channel_encryption_type         = optional(set(string))
      kerberos_ticket_encryption_type = optional(set(string))
      multichannel_enabled            = optional(bool)
      versions                        = optional(set(string))
    }))
  })
  description = "A share_properties block as defined below."
}

variable "static_website" {
  type = object({
    error_404_document = optional(string)
    index_document     = optional(string)
  })
  description = "The static_website block of azurerm_storage_account."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  description = "The timeouts block of azurerm_storage_account."
}
