# outputs.tf in modules/load_balancer

output "load_balancer_ip" {
  description = "Public IP address of the Load Balancer"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

output "load_balancer_id" {
  value = azurerm_lb.load_balancer.id
}