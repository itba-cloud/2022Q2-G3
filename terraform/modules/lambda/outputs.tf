# --------------------------------------------------------------------
# Lambda outputs
# --------------------------------------------------------------------

output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = aws_lambda_function.this.invoke_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = aws_lambda_function.this.function_name
}
