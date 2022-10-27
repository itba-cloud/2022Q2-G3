module "sqs" {
  source = "../modules/sqs"

  providers = {
    aws = aws.aws
  }

  name = "AWS-SQS-g3"
  lambda_name = "AWSLambdaHandler-${replace(local.bucket_name, "-", "")}"

  tags = {
    name = "SQS"
  }
}
