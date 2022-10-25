module "apigw" {
  source = "../modules/apigw"

  providers = {
    aws = aws.aws
  }

  depends_on = [
    module.lambda
  ]

  name                 = "AWSAPIGateway-g3"
  description          = "..."
  # lambda_function_arn  = module.lambda["lambda"].lambda_function_arn
  # lambda_function_name = module.lambda["lambda"].lambda_function_name
  # lambda_source_arn    = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"

  tags = {
    name = "Api Gateway"
  }
}
