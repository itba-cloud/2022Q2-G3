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
  website_id  = module.s3["website"].id
  content     = data.template_file.userdata.rendered
}
