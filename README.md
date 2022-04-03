# AWS IAM User with rotating credentials

Defines an AWS IAM User, and rotates its credentials every so often

## WARNING

Currently, due to a missing feature in the resource in the AWS provider, there
will be moments

See https://github.com/hashicorp/terraform-provider-aws/issues/23180#issuecomment-1086865083


## Usage

```
module "creds" {
  source = "lucydavinhart/terraform-aws-rotating_iam_creds"

  user_name     = "my-admin-user"
  policy_arn    = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# then reference creds with:
#	module.creds.current_key.id
#	module.creds.current_key.secret
```
