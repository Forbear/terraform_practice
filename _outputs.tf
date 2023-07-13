
output "subnets" {
  description = "Subnets id list configured for vpc."
  value       = { for subnet in aws_subnet.by_terraform : subnet.tags["Name"] => subnet.id }
}

output "www-open-NLB-DNS-name" {
  description = "www-open NLB DNS name"
  value       = aws_lb.by_terraform_www_open.dns_name
}
