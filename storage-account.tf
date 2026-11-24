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
##  modules/storage-account/storage-account.tf
##
##  Creates an Azure storage account, named and tagged through the Raring Group context module, exposing every azurerm_storage_account argument.
## ----------------------------------------------------------------------------

## Storage Account Context
module "storage_account_context" {
  source  = "git::https://github.com/raringgroup/terraform-null-context.git?ref=v0.1.0"
  context = module.context.self

  delimiter           = ""
  label_value_case    = "lower"
  regex_replace_chars = "/[^a-zA-Z0-9]/"
}


## Storage Account
resource "azurerm_storage_account" "this" {
  count = module.storage_account_context.enabled ? 1 : 0

  access_tier                       = var.access_tier
  account_kind                      = var.account_kind
  account_replication_type          = var.account_replication_type
  account_tier                      = var.account_tier
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  allowed_copy_scope                = var.allowed_copy_scope
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  dns_endpoint_type                 = var.dns_endpoint_type
  edge_zone                         = var.edge_zone
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  is_hns_enabled                    = var.is_hns_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  local_user_enabled                = var.local_user_enabled
  location                          = var.location
  min_tls_version                   = var.min_tls_version
  name                              = coalesce(var.name_override, module.storage_account_context.id)
  nfsv3_enabled                     = var.nfsv3_enabled
  provisioned_billing_model_version = var.provisioned_billing_model_version
  public_network_access_enabled     = var.public_network_access_enabled
  queue_encryption_key_type         = var.queue_encryption_key_type
  resource_group_name               = var.resource_group_name
  sftp_enabled                      = var.sftp_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  table_encryption_key_type         = var.table_encryption_key_type
  tags                              = module.storage_account_context.tags

  dynamic "azure_files_authentication" {
    for_each = var.azure_files_authentication == null ? [] : [var.azure_files_authentication]
    content {
      default_share_level_permission = azure_files_authentication.value.default_share_level_permission
      directory_type                 = azure_files_authentication.value.directory_type

      dynamic "active_directory" {
        for_each = azure_files_authentication.value.active_directory == null ? [] : [azure_files_authentication.value.active_directory]
        content {
          domain_guid         = active_directory.value.domain_guid
          domain_name         = active_directory.value.domain_name
          domain_sid          = active_directory.value.domain_sid
          forest_name         = active_directory.value.forest_name
          netbios_domain_name = active_directory.value.netbios_domain_name
          storage_sid         = active_directory.value.storage_sid
        }
      }
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties == null ? [] : [var.blob_properties]
    content {
      change_feed_enabled           = blob_properties.value.change_feed_enabled
      change_feed_retention_in_days = blob_properties.value.change_feed_retention_in_days
      default_service_version       = blob_properties.value.default_service_version
      last_access_time_enabled      = blob_properties.value.last_access_time_enabled
      versioning_enabled            = blob_properties.value.versioning_enabled

      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy == null ? [] : [blob_properties.value.container_delete_retention_policy]
        content {
          days = container_delete_retention_policy.value.days
        }
      }

      dynamic "cors_rule" {
        for_each = blob_properties.value.cors_rule == null ? [] : blob_properties.value.cors_rule
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy == null ? [] : [blob_properties.value.delete_retention_policy]
        content {
          days                     = delete_retention_policy.value.days
          permanent_delete_enabled = delete_retention_policy.value.permanent_delete_enabled
        }
      }

      dynamic "restore_policy" {
        for_each = blob_properties.value.restore_policy == null ? [] : [blob_properties.value.restore_policy]
        content {
          days = restore_policy.value.days
        }
      }
    }
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain == null ? [] : [var.custom_domain]
    content {
      name          = custom_domain.value.name
      use_subdomain = custom_domain.value.use_subdomain
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key == null ? [] : [var.customer_managed_key]
    content {
      key_vault_key_id          = customer_managed_key.value.key_vault_key_id
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

  dynamic "identity" {
    for_each = var.identity == null ? [] : [var.identity]
    content {
      identity_ids = identity.value.identity_ids
      type         = identity.value.type
    }
  }

  dynamic "immutability_policy" {
    for_each = var.immutability_policy == null ? [] : [var.immutability_policy]
    content {
      allow_protected_append_writes = immutability_policy.value.allow_protected_append_writes
      period_since_creation_in_days = immutability_policy.value.period_since_creation_in_days
      state                         = immutability_policy.value.state
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [var.network_rules]
    content {
      bypass                     = network_rules.value.bypass
      default_action             = network_rules.value.default_action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids

      dynamic "private_link_access" {
        for_each = network_rules.value.private_link_access == null ? [] : network_rules.value.private_link_access
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties == null ? [] : [var.queue_properties]
    content {

      dynamic "cors_rule" {
        for_each = queue_properties.value.cors_rule == null ? [] : queue_properties.value.cors_rule
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "hour_metrics" {
        for_each = queue_properties.value.hour_metrics == null ? [] : [queue_properties.value.hour_metrics]
        content {
          enabled               = hour_metrics.value.enabled
          include_apis          = hour_metrics.value.include_apis
          retention_policy_days = hour_metrics.value.retention_policy_days
          version               = hour_metrics.value.version
        }
      }

      dynamic "logging" {
        for_each = queue_properties.value.logging == null ? [] : [queue_properties.value.logging]
        content {
          delete                = logging.value.delete
          read                  = logging.value.read
          retention_policy_days = logging.value.retention_policy_days
          version               = logging.value.version
          write                 = logging.value.write
        }
      }

      dynamic "minute_metrics" {
        for_each = queue_properties.value.minute_metrics == null ? [] : [queue_properties.value.minute_metrics]
        content {
          enabled               = minute_metrics.value.enabled
          include_apis          = minute_metrics.value.include_apis
          retention_policy_days = minute_metrics.value.retention_policy_days
          version               = minute_metrics.value.version
        }
      }
    }
  }

  dynamic "routing" {
    for_each = var.routing == null ? [] : [var.routing]
    content {
      choice                      = routing.value.choice
      publish_internet_endpoints  = routing.value.publish_internet_endpoints
      publish_microsoft_endpoints = routing.value.publish_microsoft_endpoints
    }
  }

  dynamic "sas_policy" {
    for_each = var.sas_policy == null ? [] : [var.sas_policy]
    content {
      expiration_action = sas_policy.value.expiration_action
      expiration_period = sas_policy.value.expiration_period
    }
  }

  dynamic "share_properties" {
    for_each = var.share_properties == null ? [] : [var.share_properties]
    content {

      dynamic "cors_rule" {
        for_each = share_properties.value.cors_rule == null ? [] : share_properties.value.cors_rule
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "retention_policy" {
        for_each = share_properties.value.retention_policy == null ? [] : [share_properties.value.retention_policy]
        content {
          days = retention_policy.value.days
        }
      }

      dynamic "smb" {
        for_each = share_properties.value.smb == null ? [] : [share_properties.value.smb]
        content {
          authentication_types            = smb.value.authentication_types
          channel_encryption_type         = smb.value.channel_encryption_type
          kerberos_ticket_encryption_type = smb.value.kerberos_ticket_encryption_type
          multichannel_enabled            = smb.value.multichannel_enabled
          versions                        = smb.value.versions
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = var.static_website == null ? [] : [var.static_website]
    content {
      error_404_document = static_website.value.error_404_document
      index_document     = static_website.value.index_document
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  lifecycle {
    precondition {
      condition     = can(regex("^[a-z0-9]{3,24}$", coalesce(var.name_override, module.storage_account_context.id)))
      error_message = "The storage account name must be 3 to 24 lowercase letters and digits. For a generated name, use more letters or digits in namespace, environment, stage or name if it is shorter than 3 characters, or shorter values if it is longer than 24. A name_override must meet the same rule."
    }
  }
}
