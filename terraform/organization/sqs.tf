module "sqs" {
  source = "../modules/sqs"

  providers = {
    aws = aws.aws
  }

  name = "AWS-SQS-g3"

  tags = {
    name = "SQS"
  }
}
