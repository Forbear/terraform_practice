
resource "aws_route" "perimeter_engress" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.perimeter.id
  route_table_id         = aws_vpc.perimeter.default_route_table_id
  depends_on             = [aws_vpc.perimeter, ]
}
