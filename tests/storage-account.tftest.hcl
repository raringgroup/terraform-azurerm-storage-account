mock_provider "azurerm" {}

variables {
  namespace   = "example"
  environment = "dev"
  name        = "app"

  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  location                        = "eastus"
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = false
  resource_group_name             = "rg-test"
  shared_access_key_enabled       = false

  access_tier                       = null
  account_kind                      = null
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
  nfsv3_enabled                     = null
  provisioned_billing_model_version = null
  queue_encryption_key_type         = null
  sftp_enabled                      = null
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

run "the_module_adds_no_attributes_of_its_own" {
  command = plan

  assert {
    condition     = azurerm_storage_account.this[0].name == "exampledevapp"
    error_message = "with no attributes passed, the generated name must be the context labels only (no st suffix)"
  }
  assert {
    condition     = output.name == "exampledevapp"
    error_message = "the name output must match the resource name"
  }
}

run "callers_control_the_whole_name_with_attributes" {
  command = plan

  variables {
    label_order = ["environment", "namespace", "name", "attributes"]
    attributes  = ["data"]
  }

  assert {
    condition     = azurerm_storage_account.this[0].name == "devexampleappdata"
    error_message = "the name must follow label_order and the attributes the caller passes"
  }
}

run "another_attribute_gives_another_name" {
  command = plan

  variables {
    label_order = ["environment", "namespace", "name", "attributes"]
    attributes  = ["ext"]
  }

  assert {
    condition     = azurerm_storage_account.this[0].name == "devexampleappext"
    error_message = "a different attribute must give a different name"
  }
}

run "passing_st_as_the_last_attribute_restores_the_old_name" {
  command = plan

  variables {
    label_order = ["attributes", "namespace", "environment", "stage", "name"]
    attributes  = ["ext", "st"]
  }

  assert {
    condition     = azurerm_storage_account.this[0].name == "extstexampledevapp"
    error_message = "attributes ext + st must reproduce the name the previous version generated"
  }
}

run "name_override_is_used_as_given" {
  command = plan

  variables {
    name_override = "devexampleappdata"
    attributes    = ["ignored"]
  }

  assert {
    condition     = azurerm_storage_account.this[0].name == "devexampleappdata"
    error_message = "name_override must be the exact account name"
  }
  assert {
    condition     = output.name == "devexampleappdata"
    error_message = "the name output must show the override"
  }
}

run "tags_come_from_the_context_even_with_an_override" {
  command = plan

  variables {
    name_override = "devexampleappdata"
  }

  assert {
    condition     = azurerm_storage_account.this[0].tags["Namespace"] == "example" && azurerm_storage_account.this[0].tags["Environment"] == "dev" && azurerm_storage_account.this[0].tags["Name"] == "exampledevapp"
    error_message = "tags must come from the context; the Name tag keeps the generated name"
  }
}

run "an_empty_override_falls_back_to_the_generated_name" {
  command = plan

  variables {
    name_override = ""
  }

  assert {
    condition     = azurerm_storage_account.this[0].name == "exampledevapp"
    error_message = "an empty name_override must fall back to the generated name"
  }
}

run "an_override_with_uppercase_or_hyphens_is_rejected" {
  command = plan

  variables {
    name_override = "My-Account"
  }

  expect_failures = [azurerm_storage_account.this]
}

run "an_override_shorter_than_3_is_rejected" {
  command = plan

  variables {
    name_override = "ab"
  }

  expect_failures = [azurerm_storage_account.this]
}

run "an_override_longer_than_24_is_rejected" {
  command = plan

  variables {
    name_override = "abcdefghijklmnopqrstuvwxy"
  }

  expect_failures = [azurerm_storage_account.this]
}

run "a_generated_name_longer_than_24_is_rejected" {
  command = plan

  variables {
    name       = "averylongworkloadname"
    attributes = ["data"]
  }

  expect_failures = [azurerm_storage_account.this]
}

run "a_disabled_module_creates_nothing" {
  command = plan

  variables {
    enabled       = false
    name_override = "devexampleappdata"
  }

  assert {
    condition     = length(azurerm_storage_account.this) == 0 && output.name == null
    error_message = "a disabled module must create nothing and output a null name"
  }
}
