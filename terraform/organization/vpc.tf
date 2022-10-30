# ------------------------------------------------------------------------------
# VPC Module (from terraform-aws-modules)
# ------------------------------------------------------------------------------

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  providers = {
    aws = aws.aws
  }

  name = "vpc-g3-bsmsapp"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  create_database_subnet_group = false

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "vpc-g3-bsmsapp-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "vpc-g3-bsmsapp-default" }

  private_dedicated_network_acl = true
  private_inbound_acl_rules     = local.private_inbound
  private_outbound_acl_rules    = local.private_outbound

  manage_default_security_group = true
  default_security_group_tags   = { Name = "vpc-g3-bsmsapp-default" }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Name = "vpc-g3-bsmsapp"
  }
}

module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  depends_on = [
    module.dynamodb
  ]

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    dynamodb = {
      service            = "dynamodb"
      service_type       = "Gateway"
      route_table_ids    = flatten([module.vpc.private_route_table_ids])
      policy             = data.aws_iam_policy_document.this.json
      tags               = { Name = "dynamodb-vpc-endpoint" }
      security_group_ids = [aws_security_group.dynamodb_sg.id]
    }
  }

  tags = {
    Name     = "vpc-g3-bsmsapp"
    Endpoint = "true"
  }
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.us-east-1.dynamodb"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group" "dynamodb_sg" {
  name_prefix = "vpc-g3-bsmsapp-dsg"
  description = "Allow HTTPs outbound traffic"
  vpc_id      = module.vpc.vpc_id

  egress {
    description     = "HTTPs to DynamoDB"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = [aws_vpc_endpoint.dynamodb_endpoint.prefix_list_id]
  }

  tags = {
    Name = "vpc-g3-bsmsapp"
  }
}

resource "aws_security_group" "vpc_tls" {
  name_prefix = "vpc-g3-bsmsapp-vpc_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = {
    Name = "vpc-g3-bsmsapp"
  }
}
