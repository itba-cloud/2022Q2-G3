# --------------------------------------------------------------------
# Amazon API Gateway outputs
# --------------------------------------------------------------------

output "api_endpoint" {
  value = aws_api_gateway_stage.this.invoke_url
}

output "api_rest_id" {
  value = aws_api_gateway_resource.this.rest_api_id
}

output "api_resource_path" {
  value = aws_api_gateway_resource.this.path
}

output "api_http_method" {
  value = aws_api_gateway_method.this.http_method
}
