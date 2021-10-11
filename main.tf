resource "aci_rest" "fvnsVlanInstP" {
  dn         = "uni/infra/vlanns-[${var.name}]-${var.allocation}"
  class_name = "fvnsVlanInstP"
  content = {
    name      = var.name
    allocMode = var.allocation
  }
}

resource "aci_rest" "fvnsEncapBlk" {
  for_each   = { for range in var.ranges : range.from => range }
  dn         = "${aci_rest.fvnsVlanInstP.dn}/from-[vlan-${each.value.from}]-to-[${each.value.to == null ? "vlan-${each.value.from}" : "vlan-${each.value.to}"}]"
  class_name = "fvnsEncapBlk"
  content = {
    from      = "vlan-${each.value.from}"
    to        = each.value.to == null ? "vlan-${each.value.from}" : "vlan-${each.value.to}"
    allocMode = each.value.allocation != null ? each.value.allocation : "inherit"
    role      = each.value.role != null ? each.value.role : "external"
  }
}
