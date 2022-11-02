module "lambda" {
  for_each = local.lambdas
  source   = "../modules/lambda"

  providers = {
    aws = aws.aws
  }

  depends_on = [
    module.vpc
  ]

  function_name = each.value.function_name
  handler       = each.value.handler
  runtime       = each.value.runtime
  package       = each.value.package
  iam_role      = each.value.role

  vpc_subnet_ids         = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.dynamodb_sg.id]
}
