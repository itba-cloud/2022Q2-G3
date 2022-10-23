# ------------------------------------------------------------------------
# Amazon Lambda variables
# ------------------------------------------------------------------------

variable "package" {
  description = "The absolute path to an existing zip-file to use."
  type        = string
  default     = null
}


variable "function_name" {
  description = "A unique name for your Lambda Function."
  type        = string
  default     = ""
}

variable "handler" {
  description = "Lambda Function entrypoint in your code."
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Lambda Function runtime."
  type        = string
  default     = ""
}

variable "iam_role" {
  description = "IAM role ARN attached to the Lambda Function."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to API gateway resources."
  type        = map(string)
  default     = {}
}

variable "source_arn" {
  description = "Lambda source ARN."
  type        = string
  default     = ""
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}
