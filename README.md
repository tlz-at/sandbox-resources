# Baseline for sandbox account

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id | The AWS ID of the account | string | - | yes |
| name | The name for the account | string | - | yes |
| region | AWS Region to deploy to | string | `us-east-2` | no |

## Outputs

| Name | Description |
|------|-------------|
| account | Account ID |
| account\_alias | The alias name for the account |
| baseline\_version | Version of the baseline module |
