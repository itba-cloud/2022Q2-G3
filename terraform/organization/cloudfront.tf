module "cloudfront" {
  source     = "../modules/cloudfront"
  depends_on = [module.s3, module.apigw]

  providers = {
    aws = aws.aws
  }

  enabled = true

  origin = {
    api-gateway = {
      domain_name = replace(replace(module.apigw.api_endpoint, "https://", ""), "/", "")
      
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
    s3 = {
      domain_name = module.s3["website"].website_endpoint

      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id        = "s3"
    viewer_protocol_policy  = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400

    forwarded_values = {
      query_string = false

      cookies = {
        forward = "none"
      }
    }
  }
}
