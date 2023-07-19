
/*
    I would like to use variables for
    key and region, but it's not allowed.
*/

terraform {
  backend "s3" {
    bucket = "tf-state-related-s3bucket"
    key    = "DEV/terraform.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_region" "current" {}

module "perimeter_network" {
  source          = "./modules/network"
  config_version  = 0.1
  environment     = var.environment
  internet_facing = false
  manager         = "terraform"
  subnets         = var.subnets_map["base_c"]
  vpc_cidr        = var.vpc_cidr
}
