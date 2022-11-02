# --------------------------------------------------------------------
# Amazon API Gateway outputs
# --------------------------------------------------------------------

output "endpoint" {
  value = aws_api_gateway_stage.this.invoke_url
}

output "rest_id" {
  value = aws_api_gateway_resource.this.rest_api_id
}

output "resource_path" {
  value = aws_api_gateway_resource.this.path
}

