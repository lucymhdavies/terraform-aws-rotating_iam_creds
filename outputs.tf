locals {
  current_key = toggles_leapfrog.toggle.alpha ? aws_iam_access_key.tf-alpha[0] : aws_iam_access_key.tf-beta[0]
}
output "current_key" {
  value = local.current_key
}

output "iam_user" {
  value = aws_iam_user.tf
}
