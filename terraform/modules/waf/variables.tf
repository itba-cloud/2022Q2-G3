# ------------------------------------------------------------------------------
# WAF variables
# ------------------------------------------------------------------------------

variable "name" {
  description = "This is the human-readable name of the WAF."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "scope" {
  description = "WAF scope (cloudfront or regional)."
  type        = string
}

variable "rule" {
  description = "Map of WAF rules."
  type        = map(any)
  default     = {}
}
