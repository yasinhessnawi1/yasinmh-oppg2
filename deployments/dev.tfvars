environment         = "dev"
subscription_id     = "c07d12e1-5880-4a69-837d-8004c99145fc"
key_vault_access_policies = [
  {
    tenant_id           = "72f988bf-86f1-41af-91ab-2d7cd011db47"
    object_id           = "f4d7b3f3-8b0b-4b1b-8b3b-3b3b3b3b3b3b"
    secret_permissions  = ["get", "list"]
    key_permissions     = ["get", "list"]
    storage_permissions = ["get", "list"]
  }
]