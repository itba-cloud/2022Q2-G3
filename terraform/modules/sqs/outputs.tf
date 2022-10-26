# --------------------------------------------------------------------
# Lambda outputs
# --------------------------------------------------------------------

output "sqs_arn" {
  description = "The ARN of SQS"
  value       = aws_sqs_queue.this.arn
}
