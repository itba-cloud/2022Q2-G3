# ---------------------------------------------------------------------------
# Main resources
# ---------------------------------------------------------------------------

data "aws_region" "current" {
  provider = aws.aws
}

data "aws_caller_identity" "current" {
  provider = aws.aws
}

data "template_file" "userdata" {
  template = file("${path.module}/html/index.html")
  vars = {
    ENDPOINT = "${module.apigw.api_endpoint}"
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${module.dynamodb.name}"]
  }
}
