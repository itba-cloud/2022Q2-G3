# --------------------------------------------------------------------
# WAF outputs
# --------------------------------------------------------------------

output "web_acl_arn" {
  description = "The web ACL ARN."
  value       = aws_wafv2_web_acl.this.arn
}
