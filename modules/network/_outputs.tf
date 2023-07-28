
output "vpc_id" {
  description = "VPC id."
  value       = aws_vpc.primary.id
}

output "vpc_detault_route_table_id" {
  description = "Automatically generated route table."
  value       = aws_vpc.primary.default_route_table_id
}

output "internet_facing" {
  description = "Indicates if configured VPC internet facing."
  value       = var.internet_facing
}

output "subnets" {
  description = "Subnets id list configured for vpc."
  value       = [ for subnet in aws_subnet.primary : subnet.id ]
}

output "subnets_extended" {
  description = "Subnets id list configured for vpc."
  value       = { for subnet in aws_subnet.primary : subnet.tags["Name"] => subnet.id }
}

/*
output "" {
  description = ""
  value       = aws_internet_gateway.primary
}
*/
