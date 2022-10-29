module "apigw" {
  source = "../modules/apigw"

  providers = {
    aws = aws.aws
  }

  depends_on = [
    module.lambda, module.sqs
  ]

  name = "AWSAPIGateway-g3"

  lambda = [
    {
      http_method          = "GET"
      lambda_function_arn  = module.lambda["lambdaDB"].lambda_function_arn
      lambda_function_name = module.lambda["lambdaDB"].lambda_function_name
      lambda_source_arn    = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"
    }
  ]

  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
  sqs_arn  = "arn:aws:apigateway:${data.aws_region.current.name}:sqs:path/${module.sqs.name}"

  tags = {
    name = "api-gateway-g3"
  }
}
