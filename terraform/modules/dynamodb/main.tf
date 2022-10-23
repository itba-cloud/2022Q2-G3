# ---------------------------------------------------------------------------
# Amazon DynamoDB
# ---------------------------------------------------------------------------

resource "aws_dynamodb_table" "this" {
  name           = var.name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  billing_mode   = var.billing_mode

  dynamic "attribute" {
    for_each = var.attributes

    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  hash_key = var.hash_key
  tags     = var.tags
}
