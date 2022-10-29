# ------------------------------------------------------------------------
# Amazon API Gateway variables
# ------------------------------------------------------------------------

variable "name" {
  description = "The name of the API."
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the API."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to API gateway resources."
  type        = map(string)
  default     = {}
}

variable "sqs_arn" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "lambda" {
  type = list(any)
}
