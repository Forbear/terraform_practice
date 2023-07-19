
resource "aws_route" "internet_engress" {
  count                  = var.internet_facing ? 1 : 0
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = [for gateway in aws_internet_gateway.primary : gateway.id][0]
  route_table_id         = aws_vpc.primary.default_route_table_id
  depends_on             = [aws_vpc.primary, ]
}
