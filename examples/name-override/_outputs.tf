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
##  examples/name-override/_outputs.tf
##
##  Outputs of the example. The name output asserts that name_override is used as given.
## ----------------------------------------------------------------------------

output "id" {
  value = module.storage_account.id
}

output "name" {
  value = module.storage_account.name

  precondition {
    condition     = module.storage_account.name == "rgnameoverrideexample"
    error_message = "name_override must be used as the exact storage account name (rgnameoverrideexample)."
  }
}

output "primary_blob_endpoint" {
  value = module.storage_account.primary_blob_endpoint
}

output "identity" {
  value = module.storage_account.identity
}
