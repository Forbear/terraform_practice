
data "aws_iam_role" "ec2_base" {
  name = "EC2Base"
}

resource "aws_iam_instance_profile" "ec2_base" {
  name = "EC2BaseProfile"
  role = data.aws_iam_role.ec2_base.name
}

/*
resource "aws_iam_role" "config_service" {
  name = "config_service_role"
  path = "/terraform/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    managed_by = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "config_service" {
  role       = aws_iam_role.config_service.name
  policy_arn = aws_iam_policy.config_service.arn
}
*/
