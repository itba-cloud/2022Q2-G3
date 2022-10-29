locals {
  bucket_name = "bsmsapp-itba-cloud-computing-g3-test"
  path        = "../resources"

  s3 = {
    website = {
      bucket_name = local.bucket_name
      path        = "../resources"

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
      bucket_name = "www.${local.bucket_name}"
    }

    logs = {
      bucket_name = "${local.bucket_name}-logs"
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
}
