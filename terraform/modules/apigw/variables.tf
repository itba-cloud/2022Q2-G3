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

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  type        = string
}

variable "lambda_source_arn" {
  type = string
}

variable "lambda_function_name" {
  description = "Name of the lambda function"
  type        = string
}
