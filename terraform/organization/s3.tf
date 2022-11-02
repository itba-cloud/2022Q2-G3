module "s3" {
  for_each = local.s3
  source   = "./../modules/s3"

  providers = {
    aws = aws.aws
  }

  bucket_name = each.value.bucket_name
  type        = each.value.type
  website     = try(each.value.website, {})
  objects     = try(each.value.objects, {})
  bucket_acl  = each.value.bucket_acl
}

resource "aws_s3_object" "this" {
  provider = aws.aws

  bucket        = module.s3["website"].id
  key           = "index.html"
  content       = data.template_file.userdata.rendered
  content_type  = "text/html"
  storage_class = "STANDARD"
}
