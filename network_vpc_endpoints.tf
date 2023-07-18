
resource "aws_vpc_endpoint" "s3" {
  vpc_endpoint_type = "Gateway"
  vpc_id            = aws_vpc.perimeter.id
  service_name      = "com.amazonaws.eu-central-1.s3"
  route_table_ids   = [aws_vpc.perimeter.default_route_table_id, ]
}
