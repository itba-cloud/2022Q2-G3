# --------------------------------------------------------------------
# Amazon Simple Queue Service outputs
# --------------------------------------------------------------------

output "sqs_arn" {
  description = "The ARN of SQS."
  value       = aws_sqs_queue.this.arn
}

output "name" {
  description = "The name of the SQS."
  value       = aws_sqs_queue.this.name
}
