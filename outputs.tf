output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}

output "openai_key" {
  sensitive = true
  value     = azurerm_cognitive_account.openai.primary_access_key
}

