
resource "aws_vpc_endpoint" "s3" {
  vpc_endpoint_type = "Gateway"
  vpc_id            = module.perimeter_network.vpc_id
  service_name      = "com.amazonaws.eu-central-1.s3"
  route_table_ids   = [module.perimeter_network.vpc_detault_route_table_id, ]
}
