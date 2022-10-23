# ---------------------------------------------------------------------------
# Amazon DynamoDB variables
# ---------------------------------------------------------------------------

variable "name" {
  description = "Name of the DynamoDB table."
  type        = string
  default     = null
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key."
  type        = string
  default     = null
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key."
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "Controls how you are billed for read/write throughput and how you manage capacity."
  type        = string
  default     = "PROVISIONED"
}

variable "write_capacity" {
  description = "The number of write units for this table."
  type        = number
  default     = 20
}

variable "read_capacity" {
  description = "The number of read units for this table."
  type        = number
  default     = 20
}

variable "attributes" {
  description = "List of nested attribute definitions (used for hash and range key)."
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
