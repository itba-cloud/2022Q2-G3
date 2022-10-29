# ------------------------------------------------------------------------
# Amazon S3 variables
# ------------------------------------------------------------------------

variable "bucket_name" {
  type        = string
  description = "The name of the bucket. Must be less than or equal to 63 characters in length."
}

variable "objects" {
  type        = map(any)
  description = ""
  default     = {}
}

variable "website" {
  type        = map(any)
  description = ""
  default     = {}
}

variable "block_public_access" {
  type        = bool
  default     = true
  description = "Determines the S3 account-level Public Access Block configuration."
}

variable "bucket_acl" {
  type        = string
  default     = "private"
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private."
}

variable "type" {
  type        = number
  default     = 1
  description = "Determines the type of the bucket. 1 for static website and 2 for logs."
}
