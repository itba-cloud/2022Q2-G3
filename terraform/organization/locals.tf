locals {
  bucket_name = "bsmsapp-itba-cloud-computing-g3-test"
  path        = "../resources"

  s3 = {
    website = {
      type        = 1
      bucket_name = local.bucket_name
      bucket_acl  = "public-read"
      path        = "../resources"

      website = {
        index_document = "index.html"
        error_document = "error.html"
      }

      objects = {
        error = {
          filename     = "html/error.html"
          content_type = "text/html"
        }
        image1 = {
          filename     = "images/image1.png"
          content_type = "image/png"
        }
        image2 = {
          filename     = "images/image2.jpg"
          content_type = "image/jpeg"
        }
      }
    }

    www-website = {
      type = 1
      website = {
        redirect_all_requests_to = {
          host_name = "${local.bucket_name}.s3-website-${data.aws_region.current.name}.amazonaws.com"
          protocol  = "http"
        }
      }

      bucket_name = "www.${local.bucket_name}"
      bucket_acl  = "public-read"
    }

    logs = {
      type        = 2
      bucket_name = "${local.bucket_name}-logs"
      bucket_acl  = "log-delivery-write"
    }
  }

  lambdas = {
    lambdaSQS = {
      package       = "${local.path}/lambda/lambdaSQS.zip"
      function_name = "AWSLambdaHandlerAPISQSDBg3test"
      role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
      handler       = "lambda_handler.main"
      runtime       = "python3.9"
    },
    lambdaDB = {
      package       = "${local.path}/lambda/lambdaDB.zip"
      function_name = "AWSLambdaHandlerAPIDBg3test"
      role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
      handler       = "lambda_handler.main"
      runtime       = "python3.9"
    }
  }

  private_inbound = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    }
  ]
  private_outbound = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    }
  ]
}
