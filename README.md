<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-vlan-pool/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-vlan-pool/actions/workflows/test.yml)

# Terraform ACI VLAN Pool Module

Manages ACI VLAN Pool

Location in GUI:
`Fabric` » `Access Policies` » `Pools` » `VLAN`

## Examples

```hcl
module "aci_vlan_pool" {
  source  = "netascode/vlan-pool/aci"
  version = ">= 0.0.1"

  name       = "VP1"
  allocation = "dynamic"
  ranges = [{
    from       = 2
    to         = 3
    allocation = "static"
    role       = "internal"
  }]
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Vlan pool name. | `string` | n/a | yes |
| <a name="input_allocation"></a> [allocation](#input\_allocation) | Allocation mode. Choices: `static`, `dynamic`. | `string` | `"static"` | no |
| <a name="input_ranges"></a> [ranges](#input\_ranges) | List of ranges. Allowed values `from`: 1-4096. Allowed values `to`: 1-4096. Default value `to`: <from>. Choices `allocation`: `static`, `dynamic`, `inherit`. Default value `allocation`: `inherit`. Choices `role`: `internal`, `external`. Default value `role`: `external`. | <pre>list(object({<br>    from       = number<br>    to         = optional(number)<br>    allocation = optional(string)<br>    role       = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `fvnsVlanInstP` object. |
| <a name="output_name"></a> [name](#output\_name) | Vlan pool name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.fvnsEncapBlk](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fvnsVlanInstP](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->