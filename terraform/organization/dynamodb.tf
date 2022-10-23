module "dynamodb" {
  source = "../modules/dynamodb"

  providers = {
    aws = aws.aws
  }

  name           = "AWSDynamoDB-g3"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    }
  ]

  tags = {
    name = "DynamoDB-stock"
  }
}
