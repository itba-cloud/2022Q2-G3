# ---------------------------------------------------------------------------
# Amazon S3 resources
# ---------------------------------------------------------------------------

module "s3" {
  for_each = local.s3
  source   = "../../modules/s3"

  providers = {
    aws = aws.aws
  }

  bucket_name = each.value.bucket_name
  objects     = try(each.value.objects, {})
}

resource "aws_s3_object" "this" {
  provider = aws.aws

  bucket        = module.s3["website"].id
  key           = "index.html"
  content       = data.template_file.userdata.rendered
  content_type  = "text/html"
  storage_class = "STANDARD"
}

# Another way to use it, is to directly pass the following arguments to the resource

# templatefile("../../resources/html/index.html",
#   {
#     ENDPOINT = aws_api_gateway_rest_api.this.arn
#   })