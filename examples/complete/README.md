<!-- BEGIN_TF_DOCS -->
# VLAN Pool Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

```hcl
module "aci_vlan_pool" {
  source  = "netascode/vlan-pool/aci"
  version = ">= 0.1.0"

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
<!-- END_TF_DOCS -->