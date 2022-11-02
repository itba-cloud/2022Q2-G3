# ---------------------------------------------------------------------------
# Amazon CloudFront
# ---------------------------------------------------------------------------

resource "aws_cloudfront_distribution" "this" {
  web_acl_id          = var.web_acl_id
  tags                = var.tags
  enabled             = var.enabled
  default_root_object = var.default_root_object

  dynamic "origin" {
    for_each = var.origin

    content {
      domain_name = origin.value.domain_name
      origin_id   = lookup(origin.value, "origin_id", origin.key)
      origin_path = lookup(origin.value, "origin_path", "")

      dynamic "custom_origin_config" {
        for_each = length(lookup(origin.value, "custom_origin_config", "")) == 0 ? [] : [lookup(origin.value, "custom_origin_config", "")]

        content {
          http_port              = custom_origin_config.value.http_port
          https_port             = custom_origin_config.value.https_port
          origin_protocol_policy = custom_origin_config.value.origin_protocol_policy
          origin_ssl_protocols   = custom_origin_config.value.origin_ssl_protocols
        }
      }
    }
  }

  dynamic "default_cache_behavior" {
    for_each = [var.default_cache_behavior]
    iterator = i

    content {
      target_origin_id       = i.value["target_origin_id"]
      viewer_protocol_policy = i.value["viewer_protocol_policy"]

      allowed_methods = lookup(i.value, "allowed_methods", ["GET", "HEAD", "OPTIONS"])
      cached_methods  = lookup(i.value, "cached_methods", ["GET", "HEAD"])

      min_ttl     = lookup(i.value, "min_ttl", null)
      default_ttl = lookup(i.value, "default_ttl", null)
      max_ttl     = lookup(i.value, "max_ttl", null)

      forwarded_values {
        query_string = false

        cookies {
          forward = "none"
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
