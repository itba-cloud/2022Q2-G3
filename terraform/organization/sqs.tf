module "sqs" {
  source = "../modules/sqs"

  providers = {
    aws = aws.aws
  }

  depends_on = [
    module.lambda
  ]

  name        = "AWS-SQS-g3"
  lambda_name = module.lambda["lambdaSQS"].function_name

  tags = {
    name = "SQS"
  }
}
