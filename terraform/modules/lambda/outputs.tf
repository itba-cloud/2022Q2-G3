output "invoke_arn" {
  description = "The lambda function's invoke ARN"
  value       = aws_lambda_function.this.invoke_arn
}

output "function_name" {
  description = "The lambda function's name"
  value       = aws_lambda_function.this.function_name
}