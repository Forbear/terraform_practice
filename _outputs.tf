
output "subnets" {
  description = "Subnets id list configured for vpc."
  value       = { for subnet in aws_subnet.by_terraform : subnet.tags["Name"] => subnet.id }
}
