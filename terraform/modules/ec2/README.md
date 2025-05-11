<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instances"></a> [instances](#input\_instances) | List of EC2 instances to create | <pre>list(object({<br/>    name               = string<br/>    ami_id             = string<br/>    instance_type      = string<br/>    subnet_id          = string<br/>    security_group_ids = list(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ids"></a> [instance\_ids](#output\_instance\_ids) | Map of instance name → ID |
| <a name="output_public_ips"></a> [public\_ips](#output\_public\_ips) | Map of instance name → public IP |
<!-- END_TF_DOCS -->