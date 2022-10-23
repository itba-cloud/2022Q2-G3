# ---------------------------------------------------------------------------
# Amazon CloudFront variables
# ---------------------------------------------------------------------------

variable "web_acl_id" {
  description = "Id or ARN of the AWS WAF web ACL that is associated with the distribution."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = null
}

variable "origin" {
  description = "One or more origins for this distribution."
  type        = any
  default     = null
}

variable "default_root_object" {
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  type        = string
  default     = null
}

variable "default_cache_behavior" {
  description = "The default cache behavior for this distribution"
  type        = any
  default     = null
}

variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  type        = bool
  default     = true
}
