# --------------------------------------------------------------------
# WAF
# --------------------------------------------------------------------

resource "aws_wafv2_web_acl" "this" {
  name  = var.name
  scope = var.scope

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = var.rule

    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.managed_rule_group_statement
          vendor_name = "AWS"
        }
      }


      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = true
      }

    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf-bsmsapp"
    sampled_requests_enabled   = true
  }

  tags = var.tags
}
