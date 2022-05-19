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

  # required for the replace_triggered_by functionality
  required_version = ">= 1.2"
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

resource "aws_iam_access_key" "tf" {
  user = aws_iam_user.tf.name


  lifecycle {
    # Leapfrog toggle alternates between true and false, resulting in a replace trigger
    replace_triggered_by = [
      toggles_leapfrog.toggle.alpha,
    ]

    # And we always want some credentials to exist, so create before destroy
    create_before_destroy = true
  }
}
