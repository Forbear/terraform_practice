
locals {
  pg_name = "${var.environment}-pg"
}

resource "aws_placement_group" "perimeter" {
  name     = "Perimeter_placement_group"
  strategy = "spread"
  tags     = merge(var.base_tags, { Name = local.pg_name })
}
