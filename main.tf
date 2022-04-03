terraform {
  required_providers {
    toggles = {
      source  = "reinoudk/toggles"
      version = ">= 0.3.0, < 1.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8.0, < 5.0.0"
    }
  }
}

resource "aws_iam_user" "tf" {
  name = var.user_name
}
resource "aws_iam_user_policy_attachment" "tf-admin" {
  user       = aws_iam_user.tf.name
  policy_arn = var.policy_arn
}

# Use https://registry.terraform.io/providers/reinoudk/toggles/latest/docs/resources/leapfrog example to do key rotation
resource "time_rotating" "toggle_interval" {
  count         = var.always_rotate ? 0 : 1
  rotation_days = var.rotation_days
}
resource "toggles_leapfrog" "toggle" {
  trigger = var.always_rotate ? null : time_rotating.toggle_interval[0].rotation_rfc3339
}

# Using counts as a workaround for
# https://github.com/hashicorp/terraform-provider-aws/issues/23180
resource "aws_iam_access_key" "tf-alpha" {
  user  = aws_iam_user.tf.name
  count = toggles_leapfrog.toggle.alpha ? 1 : 0
}
resource "aws_iam_access_key" "tf-beta" {
  user  = aws_iam_user.tf.name
  count = toggles_leapfrog.toggle.beta ? 1 : 0
}
