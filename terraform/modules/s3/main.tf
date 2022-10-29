# ------------------------------------------------------------------------------
# Amazon S3
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "this" {
  bucket              = var.bucket_name
  object_lock_enabled = false
}

resource "aws_s3_bucket_policy" "this" {
  count = var.type == 1 ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_logging" "this" {
  count = var.type == 2 ? 1 : 0
  bucket = trimsuffix(var.bucket_name, "-logs")

  target_bucket = aws_s3_bucket.this.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_website_configuration" "this" {
  count = var.type == 1 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "index_document" {
    for_each = try([var.website["index_document"]], [])

    content {
      suffix = index_document.value
    }
  }

  dynamic "error_document" {
    for_each = try([var.website["error_document"]], [])

    content {
      key = error_document.value
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = try([var.website["redirect_all_requests_to"]], [])

    content {
      host_name = redirect_all_requests_to.value.host_name
      protocol  = try(redirect_all_requests_to.value.protocol, null)
    }
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.bucket_acl
}

resource "aws_s3_object" "this" {
  for_each = try(var.objects, {})

  bucket        = aws_s3_bucket.this.id
  key           = try(each.value.rendered, replace(each.value.filename, "html/", ""))
  source        = try(each.value.rendered, format("./../resources/%s", each.value.filename))
  content_type  = each.value.content_type
  storage_class = try(each.value.tier, "STANDARD")
}
