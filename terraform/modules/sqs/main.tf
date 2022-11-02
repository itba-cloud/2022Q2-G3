# ------------------------------------------------------------------------------
# Amazon Simple Queue Service
# ------------------------------------------------------------------------------

resource "aws_sqs_queue" "this" {
  name                        = var.name
  delay_seconds               = var.delay_seconds
  max_message_size            = var.max_message_size
  message_retention_seconds   = var.message_retention_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication

  tags = var.tags
}

resource "aws_lambda_permission" "allows_sqs_to_trigger_lambda" {
  statement_id  = "AllowExecutionFromSQS"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.this.arn
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size       = 1
  event_source_arn = aws_sqs_queue.this.arn
  enabled          = true
  function_name    = var.lambda_name
}
