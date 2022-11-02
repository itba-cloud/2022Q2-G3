module "waf" {
  source = "../modules/waf"

  providers = {
    aws = aws.aws
  }

  name  = "AWS-WAF-g3"
  scope = "CLOUDFRONT"

  tags = {
    name = "WAF"
  }
}
