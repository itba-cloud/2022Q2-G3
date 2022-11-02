module "waf" {
  source = "../modules/waf"

  providers = {
    aws = aws.aws
  }

  name  = "AWS-WAF-g3"
  scope = "CLOUDFRONT"

  rule = {
    common = {
      name                         = "AWS-AWSManagedRulesCommonRuleSet",
      priority                     = 1,
      managed_rule_group_statement = "AWSManagedRulesCommonRuleSet",
      metric_name                  = "AWS-AWSManagedRulesCommonRuleSet",
    },
    linux = {
      name                         = "AWS-AWSManagedRulesLinuxRuleSet",
      priority                     = 2,
      managed_rule_group_statement = "AWSManagedRulesLinuxRuleSet",
      metric_name                  = "AWS-AWSManagedRulesLinuxRuleSet",
    },
    input = {
      name                         = "AWS-AWSManagedRulesKnownBadInputsRuleSet",
      priority                     = 3,
      managed_rule_group_statement = "AWSManagedRulesKnownBadInputsRuleSet",
      metric_name                  = "AWS-AWSManagedRulesKnownBadInputsRuleSet",
    }
  }

  tags = {
    name = "WAF"
  }
}
