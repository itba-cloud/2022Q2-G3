# ------------------------------------------------------------------------
# Amazon API Gateway variables
# ------------------------------------------------------------------------

variable "name" {
  description = "The name of the API."
  type        = string
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

variable "method" {
  description = "Map of API gateway methods."
  type        = map(any)
}

variable "integration" {
  description = "Map of API gateway integrations."
  type        = map(any)
}

variable "method_response" {
  description = "Map of API gateway method response."
  type        = map(any)
}

variable "integration_response" {
  description = "Map of API gateway method integrations."
  type        = map(any)
}
