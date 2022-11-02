# --------------------------------------------------------------------
# DynamoDB outputs
# --------------------------------------------------------------------

output "name" {
  description = "The name of the table."
  value       = aws_dynamodb_table.this.name
}
