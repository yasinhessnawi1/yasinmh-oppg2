# Output storage information
output "storage_account_name" {
  value = module.storage.storage_account_name
}
output "vnet_id" {
  value = module.network.vnet_id
}
output "website_subnet_id" {
  value = module.network.website_subnet_id
}
output "db_subnet_id" {
  value = module.network.db_subnet_id
}
output "key_vault_id" {
  value = module.key_vault.key_vault_id
}