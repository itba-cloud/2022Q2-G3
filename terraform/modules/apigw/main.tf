# ---------------------------------------------------------------------------
# Amazon API Gateway
# ---------------------------------------------------------------------------

resource "aws_api_gateway_rest_api" "this" {
  name = var.name
  tags = var.tags
}

resource "aws_api_gateway_resource" "this" {
  path_part   = "products"
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_method" "this" {
  for_each = var.method

  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = each.value.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "this" {
  for_each = var.integration

  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = aws_api_gateway_method.this[each.key].http_method
  integration_http_method = each.value.integration_http_method
  type                    = each.value.type
  credentials             = each.value.credentials
  uri                     = each.value.uri
  request_parameters      = each.value.request_parameters
  request_templates       = each.value.request_templates

  depends_on = [aws_api_gateway_method.this]
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "production"
}

resource "aws_api_gateway_method_response" "this" {
  for_each = var.method_response

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this[each.key].http_method
  status_code = 200

  response_models     = each.value.response_models
  response_parameters = each.value.response_parameters

  depends_on = [aws_api_gateway_method.this]
}

resource "aws_api_gateway_integration_response" "this" {
  for_each = var.integration_response

  rest_api_id         = aws_api_gateway_rest_api.this.id
  resource_id         = aws_api_gateway_resource.this.id
  http_method         = aws_api_gateway_method.this[each.key].http_method
  status_code         = aws_api_gateway_method_response.this[each.key].status_code
  selection_pattern   = each.value.selection_pattern
  response_parameters = each.value.response_parameters

  depends_on = [aws_api_gateway_method_response.this]
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.this.id,
      aws_api_gateway_method.this["get"].id,
      aws_api_gateway_method.this["post"].id,
      aws_api_gateway_method.this["options"].id,
      aws_api_gateway_integration.this["get"].id,
      aws_api_gateway_integration.this["post"].id,
      aws_api_gateway_integration.this["options"].id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.this,
    aws_api_gateway_method.this,
    aws_api_gateway_method_response.this,
    aws_api_gateway_integration_response.this
  ]
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda[0].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.lambda[0].source_arn}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.this["get"].http_method}${aws_api_gateway_resource.this.path}"
}
