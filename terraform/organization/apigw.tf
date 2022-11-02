module "apigw" {
  source = "../modules/apigw"

  providers = {
    aws = aws.aws
  }

  depends_on = [
    module.lambda,
    module.sqs
  ]

  name = "AWSAPIGateway-g3"

  lambda = [
    {
      function_arn  = module.lambda["lambdaDB"].function_arn
      function_name = module.lambda["lambdaDB"].function_name
      source_arn    = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}"
    }
  ]

  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
  sqs_arn  = "arn:aws:apigateway:${data.aws_region.current.name}:sqs:path/${module.sqs.name}"

  method = {
    get = {
      http_method = "GET"
    }
    post = {
      http_method = "POST"
    },
    options = {
      http_method = "OPTIONS"
    },
  }

  integration = {
    get = {
      integration_http_method = "POST",
      type                    = "AWS_PROXY",
      credentials             = null,
      uri                     = module.lambda["lambdaDB"].function_arn,
      request_parameters      = {},
      request_templates       = {},
    },
    post = {
      integration_http_method = "POST",
      type                    = "AWS",
      credentials             = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole",
      uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:sqs:path/${module.sqs.name}",
      request_parameters = {
        "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
      },
      request_templates = {
        "application/json" = file("template.json")
      }
    },
    options = {
      integration_http_method = null,
      type                    = "MOCK",
      credentials             = null,
      uri                     = null,
      request_parameters      = {},
      request_templates = {
        "application/json" = jsonencode(
          {
            statusCode = 200
          }
        )
      }
    },
  }

  method_response = {
    get = {
      response_models = {}
      response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = "true"
      }
    },
    post = {
      response_models = {}
      response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = "true"
      }
    },
    options = {
      response_models = {
        "application/json" = "Empty"
      }
      response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true,
        "method.response.header.Access-Control-Allow-Methods" = true,
        "method.response.header.Access-Control-Allow-Origin"  = true
      }
    }
  }

  integration_response = {
    get = {
      selection_pattern = "^2[0-9][0-9]"
      response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
      }
    },
    post = {
      selection_pattern = "^2[0-9][0-9]"
      response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
      }
    },
    options = {
      selection_pattern = null
      response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST'",
        "method.response.header.Access-Control-Allow-Origin"  = "'*'"
      }
    }
  }

  tags = {
    name = "api-gateway-g3"
  }
}
