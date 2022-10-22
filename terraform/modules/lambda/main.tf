# ------------------------------------------------------------------------------
# Amazon Lambda
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "this" {
  filename      = var.package
  function_name = var.function_name
  role          = var.iam_role
  handler       = var.handler
  runtime       = var.runtime
  tags          = var.tags

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }
}
