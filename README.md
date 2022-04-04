# AWS IAM User with rotating credentials

Defines an AWS IAM User, and rotates its credentials every so often

## WARNING

Currently, due to a missing feature in the resource in the AWS provider, there
will be moments where the VarSet contains invalid credentials. This is currently
unavoidable, without making this module significantly more complicated.

See https://github.com/hashicorp/terraform-provider-aws/issues/23180#issuecomment-1086865083

## Usage

```
module "creds" {
  source = "lucymhdavies/rotating_iam_creds/aws"

  user_name     = "my-admin-user"
  policy_arn    = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# then reference creds with:
#	module.creds.current_key.id
#	module.creds.current_key.secret
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8.0, < 5.0.0 |
| <a name="requirement_toggles"></a> [toggles](#requirement\_toggles) | >= 0.3.0, < 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.8.0, < 5.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |
| <a name="provider_toggles"></a> [toggles](#provider\_toggles) | >= 0.3.0, < 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.tf-alpha](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.tf-beta](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.tf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.tf-admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [time_rotating.toggle_interval](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [toggles_leapfrog.toggle](https://registry.terraform.io/providers/reinoudk/toggles/latest/docs/resources/leapfrog) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_always_rotate"></a> [always\_rotate](#input\_always\_rotate) | n/a | `bool` | `false` | no |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | n/a | `string` | n/a | yes |
| <a name="input_rotation_days"></a> [rotation\_days](#input\_rotation\_days) | n/a | `number` | `7` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_current_key"></a> [current\_key](#output\_current\_key) | n/a |
| <a name="output_iam_user"></a> [iam\_user](#output\_iam\_user) | n/a |

