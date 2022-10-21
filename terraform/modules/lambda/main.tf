# ------------------------------------------------------------------------------
# Amazon Lambda
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "this" {

  filename      = var.lambda_info.filename
  function_name = var.lambda_info.function_name
  role          = var.iam_role_arn
  handler       = var.lambda_info.handler
  runtime       = var.runtime

  tags = {
    name = "lambda${var.lambda_info.function_name}"
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.apigw_execution_arn}/*/${var.lambda_info.method}${var.lambda_info.path}"
}
