# ------------------------------------------------------------------------
# Amazon API Gateway variables
# ------------------------------------------------------------------------

variable "name" {
  description = "The name of the API."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to API gateway resources."
  type        = map(string)
  default     = {}
}

variable "sqs_arn" {
  description = "ARN of the SQS."
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role (credentials)."
  type        = string
}

variable "lambda" {
  description = "List of lambdas the API will execute."
  type        = list(any)
}
