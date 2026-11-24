# Changelog

## v0.2.0 (breaking change)

### Breaking change

- The module no longer adds the attribute `st` to the generated storage account name. The inner `storage_account_context` call now sets only `delimiter = ""`, `label_value_case = "lower"` and `regex_replace_chars = "/[^a-zA-Z0-9]/"`, which Azure requires because storage account names allow only lowercase letters and digits. Callers pass their own attributes through the context.
- **Effect:** generated names no longer end in `st`. For the same inputs, `extstexampledevapp` becomes `extexampledevapp`. Callers that rely on the generated name will see their storage account renamed. Changing the name of a storage account forces a new resource, so Terraform replaces the account (destroy and create) and its data is not migrated.
- **To keep an existing account**, either pass `st` as the last attribute (for example `attributes = ["ext", "st"]`, which reproduces the v0.1.0 name for the same `label_order`) or set `name_override` to the existing account name. Check the plan before applying.

### Added

- `name_override` (string, default `null`): sets the exact account name. It must be 3 to 24 lowercase letters and digits, and changing it replaces the account. It is the only input with a default.
- `name` output: the final account name (the override when set, otherwise the generated name; null when the module is disabled).
- `tests/storage-account.tftest.hcl`: mock-provider tests for the generated name, caller-controlled attributes, `name_override`, tags and the 3 to 24 character rule.
- `examples/name-override`: sets `name_override` and asserts the resulting name in its outputs.

### Changed

- `examples/complete` passes its own attributes (`attributes = ["data"]`) and leaves the project out of the name, so the account name stays within 24 characters.
- README: naming rules, a `name_override` section, the upgrade notes above, the `name` output and an examples list.

## v0.1.0

- Initial release.
